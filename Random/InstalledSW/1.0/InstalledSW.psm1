function Get-InstalledSW {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)][string]$Computer,
        [Parameter(Mandatory)][string]$OUClient
    )
    Show-UDModal -Header { "All installed softwares on $Computer" } -Content {
        New-UDDynamic -Id 'InstallSWData' -content {
            New-UDRow {
                New-UDRow -Columns {
                    $ComputerObj = $(try { Get-ADComputer -Filter "samaccountname -eq '$Computer$'" -SearchBase $OUClient } catch { $Null })

                    if ($Null -ne $Computer) {
                        if ($Null -ne $ComputerObj) {
                            $AllInstall = Invoke-Command -ComputerName $Computer -Scriptblock { Get-CimInstance -ClassName win32_product | Select-Object Name, PackageName, InstallDate }
                                                
                            $InstallData = foreach ($Install in $AllInstall) {
                                [PSCustomObject]@{
                                    iName        = $Install.Name
                                    iPackageName = $Install.PackageName
                                    iInstallDate = $Install.InstallDate
                                }
                            }

                            $InstallColumns = @(
                                New-UDTableColumn -Property iName -Title "Name" -IncludeInExport -IncludeInSearch
                                New-UDTableColumn -Property iPackageName -Title "Package Name" -IncludeInExport -IncludeInSearch
                                New-UDTableColumn -Property iInstallDate -Title "Install date" -IncludeInExport -IncludeInSearch
                            )
                            if ($null -eq $InstallData) {
                                New-UDAlert -Severity 'error' -Text "Could not read any data, try again!"
                                Break
                            }
                            else {
                                New-UDTable -Id 'InstallSWSearchTable' -Data $InstallData -Columns $InstallColumns -Sort -ShowSearch -ShowPagination -Dense -Export -ExportOption "xlsx, PDF" -PageSize 20 -PageSizeOptions @(30, 40, 50)
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

Export-ModuleMember -Function "Get-InstalledSW"