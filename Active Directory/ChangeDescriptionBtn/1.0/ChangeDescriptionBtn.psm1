function New-ChangeDescriptionBtn {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)][string]$ChangeDescriptionObject,
        [Parameter(Mandatory = $false)][string]$CurrentValue,
        [Parameter(Mandatory = $false)][string]$UserName,
        [Parameter(Mandatory = $false)][string]$GroupName,
        [Parameter(Mandatory = $false)][string]$ComputerName
    )
    if ($ChangeDescriptionObject -eq 'User') {
        $ChangeDescpritionHeader = $UserName
    }
    elseif ($ChangeDescriptionObject -eq 'Group') {
        $ChangeDescpritionHeader = $GroupName
    }
    elseif ($ChangeDescriptionObject -eq 'Computer') {
        $ChangeDescpritionHeader = $ComputerName
    }
    New-UDButton -Icon (New-UDIcon -Icon pencil_square) -size small -Onclick { 
        Show-UDModal -Header { "Change the description for $($ChangeDescpritionHeader)" } -Content {
            New-UDTextbox -Id "txtChangeDescription" -Label "Description" -Value $CurrentValue
        } -Footer {
            New-UDButton -Text "Save" -OnClick { 
                $DescriptionNew = (Get-UDElement -Id "txtChangeDescription").value
                try {
                    if ($ChangeDescriptionObject -eq 'User') {
                        Set-ADUser -Identity $UserName -Description $DescriptionNew
                        Show-UDToast -Message "The Description for $($UserName) has been changed!" -MessageColor 'green' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                        Hide-UDModal
                    }
                    elseif ($ChangeDescriptionObject -eq "Group") {
                        Set-ADGroup -Identity $GroupName -Description $DescriptionNew
                        Show-UDToast -Message "The Description for $($GroupName) has been changed!" -MessageColor 'green' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                        Hide-UDModal
                    }
                    elseif ($ChangeDescriptionObject -eq "Computer") {
                        Set-ADComputer -Identity $ComputerName -Description $DescriptionNew
                        Show-UDToast -Message "The Description for $($ComputerName) has been changed!" -MessageColor 'green' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                        Hide-UDModal
                    }
                }
                catch {
                    Show-UDToast -Message "$($PSItem.Exception)" -MessageColor 'red' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                    Break
                }
            }
            New-UDButton -Text "Close" -OnClick { Hide-UDModal }
        } -FullWidth -MaxWidth 'sm' -Persistent
    }
}

Export-ModuleMember -Function "New-ChangeDescriptionBtn"