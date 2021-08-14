function Remove-UserProfiles {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)][string]$Computer,
        [Parameter(Mandatory)][string]$OUClient,
        [Parameter(Mandatory)][string]$ReplaceDomain
    )
    Show-UDModal -Header { "Delete the user profile from $Computer" } -Content {
        New-UDDynamic -Id 'ShowUsrProfdata' -content {
            New-UDRow {
                New-UDRow -Columns {
                    $ComputerObj = $(try { Get-ADComputer -Filter "samaccountname -eq '$Computer$'" -SearchBase $OUClient } catch { $Null })
                    if ($Null -ne $Computer) {
                        if ($Null -ne $ComputerObj) {
                            $Profiles = Get-WMIObject -ComputerName $Computer -class Win32_UserProfile | Where-Object { (!$_.Special) -and ($_.LocalPath -ne 'C:\Users\Administratör') -and ($_.LocalPath -ne 'C:\Users\Administrator') }

                            $SearchComputerGroupData = foreach ($Profile in $Profiles) {
                                $SID = $Profile.SID
                                $ProfileInfo = Invoke-Command -ComputerName $Computer { Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$using:SID" }
    
                                If ($null -ne $ProfileInfo.LocalProfileUnloadTimeHigh) {
                                    $PUHigh = '{0:x}' -f $ProfileInfo.LocalProfileUnloadTimeHigh
                                    $PULow = '{0:x}' -f $ProfileInfo.LocalProfileUnloadTimeLow
                                    $PUcomb = -join ('0x', $PUHigh, $PULow)
                                    $ProfileUsed = [datetime]::FromFileTime([uint64]$PUcomb)                    
 
                                    $ProfileAge = (New-TimeSpan -Start $ProfileUsed).Days #$ts.Days

                                    if ($ProfileAge -ge 3000) {
                                        $ProfileUsed = "N/A"
                                        $ProfileAge = "N/A"
                                    }
                                }
                                Else {
                                    $ProfileUsed = "N/A"
                                    $ProfileAge = "N/A"
                                }
 
                                try {
                                    $ProfileUser = (New-Object System.Security.Principal.SecurityIdentifier ($Profile.SID)).Translate( [System.Security.Principal.NTAccount]).Value
                                }
                                catch {
                                    $ProfileUser = $Profile.LocalPath
                                }

                                [PSCustomObject]@{
                                    User          = $ProfileUser
                                    ProfilePath   = $Profile.LocalPath
                                    LastUsed      = $ProfileUsed
                                    ProfileAge    = $ProfileAge
                                    ProfileLoaded = $Profile.Loaded
                                }
                            }
                            $SearchComputerGroupColumns = @(
                                New-UDTableColumn -Property User -Title "Username" -IncludeInExport -IncludeInSearch
                                New-UDTableColumn -Property ProfilePath -Title "Search path" -IncludeInExport -IncludeInSearch
                                New-UDTableColumn -Property LastUsed -Title "Last Change" -IncludeInExport -IncludeInSearch
                                New-UDTableColumn -Property ProfileAge -Title "Profile Age (Days)" -IncludeInExport -IncludeInSearch
                                New-UDTableColumn -Property ProfileLoaded -Title "Is the profile loaded?"  -Render {
                                    switch ($EventData.ProfileLoaded) {
                                        True { "Yes" }
                                        False { "No" }
                                        Default { $EventData.ProfileLoaded }
                                    }
                                }
                                New-UDTableColumn -Property Delete -Title "." -Render {
                                    New-UDButton -Icon (New-UDIcon -Icon backspace) -size small -Onclick {
                                        if ($EventData.ProfileLoaded -eq "Yes") {
                                            Show-UDToast -Message "You can't delete a user profile that are loaded!" -MessageColor 'red' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                                        }
                                        else {
                                            $Computer = (Get-UDElement -Id "txtCompName").value
                                            $UserRmProfileName = $EventData.User.Replace("$($ReplaceDomain)\", "")
                                            Show-UDModal -Content {
                                                New-UDDynamic -Id 'RMprofModal' -content {
                                                    New-UDElement -Tag 'div' -Id 'rmPopText' -Content {
                                                        New-UDHTML -Markup "<B>Do you want to delete $($UserRmProfileName)?</B>"
                                                    }
                                                } -LoadingComponent {
                                                    New-UDProgress -Circular
                                                }
                                            } -Footer {
                                                New-UDButton -text 'Yes' -size small -Onclick {
                                                    try {
                                                        Set-UDElement -Id 'rmPopText' -Content {
                                                            New-UDHTML -Markup "<B>Deleting the profile, please wait...</B>"
                                                        }
                                                        Set-UDElement -Id 'BtbJa' -Properties @{
                                                            disabled = $true 
                                                            text     = "Deleting..."
                                                        }
                                                        Set-UDElement -Id 'BtbNej' -Properties @{
                                                            disabled = $true 
                                                            text     = "Deleting..."
                                                        }
                                                        Get-WmiObject -ComputerName $Computer Win32_UserProfile | Where-Object { $_.LocalPath -eq "C:\Users\$UserRmProfileName" } | Remove-WmiObject
                                                        Sync-UDElement -id 'ShowUsrProfdata'
                                                        Hide-UDModal
                                                        Show-UDToast -Message "The profile $($UserRmProfileName) are now deleted!" -MessageColor 'green' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                                                    }
                                                    catch {
                                                        Show-UDToast -Message "$($PSItem.Exception)" -MessageColor 'red' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                                                        Hide-UDModal
                                                        Break
                                                    }
                                                } -Id 'BtbJa'
                                                New-UDButton -text 'No' -size small -Onclick {
                                                    Hide-UDModal
                                                } -Id 'BtbNej'
                                            } -FullWidth -MaxWidth 'sm' -Persistent
                                        }
                                    }
                                }
                            )
                            if ($null -eq $SearchComputerGroupData) {
                                New-UDAlert -Severity 'error' -Text "Could not read any data, the computer is probably turned off!"
                                Break
                            }
                            else {
                                New-UDTable -Id 'ComputerSearchTable' -Data $SearchComputerGroupData -Columns $SearchComputerGroupColumns -Title "User profiles from $($Computer)" -Sort -ShowSelection -ShowSearch -ShowPagination -Dense -Export -ExportOption "xlsx, PDF" -PageSize 20 -PageSizeOptions @(30, 40, 50)
                                New-UDButton -Text "Delete selected" -OnClick {
                                    $ProfileTable = Get-UDElement -Id "ComputerSearchTable"
                                    $MultiProfLog = @($ProfileTable.selectedRows.User)
                                    $Computer = (Get-UDElement -Id "txtCompName").value
                                    $FixUsrMultProf = $MultiProfLog.Replace("$($ReplaceDomain)\", "")

                                    if ($null -ne $ProfileTable.selectedRows.User) {
                                        Show-UDModal -Content {
                                            New-UDElement -Tag 'div' -Id 'rmPopText' -Content {
                                                New-UDHTML -Markup "<B>Do you want to delete the following profiles? $($FixUsrMultProf)?</B>"
                                            }
                                        } -Footer {
                                            New-UDButton -text 'Yes' -size small -Onclick {
                                                Set-UDElement -Id 'rmPopText' -Content {
                                                    New-UDHTML -Markup "<B>Deleting the profile, please wait...</B>"
                                                }
                                                Set-UDElement -Id 'BtbJa' -Properties @{
                                                    disabled = $true 
                                                    text     = "Deleting..."
                                                }
                                                Set-UDElement -Id 'BtbNej' -Properties @{
                                                    disabled = $true 
                                                    text     = "Deleting..."
                                                }
                                                try {
                                                    @($ProfileTable.selectedRows.User.ForEach( { 
                                                                if ($ProfileTable.selectedRows.ProfileLoaded -eq "True") { return }
                                                                $FixUser = $_.Replace("$($ReplaceDomain)\", "")
                                                                Get-WmiObject -ComputerName $Computer Win32_UserProfile | Where-Object { $_.LocalPath -eq "C:\Users\$FixUser" } | Remove-WmiObject } ) )
                                                    Sync-UDElement -id 'ShowUsrProfdata'
                                                    Show-UDToast -Message "The user profile $($MultiProfLog) are now deleted!" -MessageColor 'green' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                                                    Hide-UDModal
                                                }
                                                catch {
                                                    Show-UDToast -Message "$($PSItem.Exception)" -MessageColor 'red' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                                                    Hide-UDModal
                                                    Break
                                                }
                                            } -Id 'BtbJa'
                                            New-UDButton -text 'No' -size small -Onclick {
                                                Hide-UDModal
                                            } -Id 'BtbNej'
                                        } -FullWidth -MaxWidth 'sm' -Persistent
                                    }
                                    else {
                                        Show-UDToast -Message "You have not selected any user profile to delete, you need to do that!" -MessageColor 'red' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                                        Break
                                    }
                                }
                            }
                        }
                        else {
                            New-UDAlert -Severity 'error' -Text "Can't find the computer $($Computer) in the AD, please try again!"
                        }
                    }
                    else {
                        New-UDAlert -Severity 'error' -Text "You must write a computer name!"
                    }
                }
            }
        } -LoadingComponent {
            New-UDProgress -Circular
        }                
    } -Footer {
        New-UDButton -Text "Close" -OnClick { Hide-UDModal }
                                        
    } -FullWidth -MaxWidth 'md' -Persistent
}

Export-ModuleMember -Function "Remove-UserProfiles"