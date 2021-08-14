function Get-InstalledDrivers {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)][string]$Computer,
        [Parameter(Mandatory)][string]$OUClient
    )
    Show-UDModal -Header { "All installed drivers on $Computer" } -Content {
        New-UDDynamic -Id 'DriversData' -content {
            New-UDRow {
                New-UDRow -Columns {
                    $ComputerObj = $(try { Get-ADComputer -Filter "samaccountname -eq '$Computer$'" -SearchBase $OUClient } catch { $Null })

                    if ($Null -ne $Computer) {
                        if ($Null -ne $ComputerObj) {
                            $AllDrivers = Invoke-Command -ComputerName $Computer -Scriptblock { Get-CimInstance win32_PnpSignedDriver | select-object Description, DeviceClass, DeviceName, DriverDate, DriverProviderName, DriverVersion, Manufacturer }
                                                
                            $DriversData = foreach ($Driver in $AllDrivers) {
                                [PSCustomObject]@{
                                    dManufacturer       = $Driver.Manufacturer
                                    dDriverProviderName = $Driver.DriverProviderName
                                    dDeviceName         = $Driver.DeviceName
                                    dDescription        = $Driver.Description
                                    dDeviceClass        = $Driver.DeviceClass
                                    dDriverVersion      = $Driver.DriverVersion
                                    dDriverDate         = $Driver.DriverDate
                                }
                            }

                            $DriversColumns = @(
                                New-UDTableColumn -Property dManufacturer -Title "Manufacturer" -IncludeInExport -IncludeInSearch
                                New-UDTableColumn -Property dDriverProviderName -Title "Driver Provider" -IncludeInExport -IncludeInSearch
                                New-UDTableColumn -Property dDeviceName -Title "Device name" -IncludeInExport -IncludeInSearch
                                New-UDTableColumn -Property dDescription -Title "Description" -IncludeInExport -IncludeInSearch
                                New-UDTableColumn -Property dDeviceClass -Title "Class" -IncludeInExport -IncludeInSearch
                                New-UDTableColumn -Property dDriverVersion -Title "Version" -IncludeInExport -IncludeInSearch
                                New-UDTableColumn -Property dDriverDate -Title "Date" -IncludeInExport -IncludeInSearch
                            )
                            if ($null -eq $DriversData) {
                                New-UDAlert -Severity 'error' -Text "Could not read any data, try again!"
                                Break
                            }
                            else {
                                New-UDTable -Id 'DriversSearchTable' -Data $DriversData -Columns $DriversColumns -Sort -ShowSearch -ShowPagination -Dense -Export -ExportOption "xlsx, PDF" -PageSize 20 -PageSizeOptions @(30, 40, 50)
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
                                        
    } -FullWidth -MaxWidth 'lg' -Persistent
}

Export-ModuleMember -Function "Get-InstalledDrivers"