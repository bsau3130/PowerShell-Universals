function Get-NetAdp {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)][string]$Computer,
        [Parameter(Mandatory)][string]$OUClient
    )
    Show-UDModal -Header { "All installed networkcards on $Computer" } -Content {
        New-UDDynamic -Id 'AdapterData' -content {
            New-UDRow {
                New-UDRow -Columns {
                    $ComputerObj = $(try { Get-ADComputer -Filter "samaccountname -eq '$Computer$'" -SearchBase $OUClient } catch { $Null })

                    if ($Null -ne $Computer) {
                        if ($Null -ne $ComputerObj) {
                            $AllAdapters = Invoke-Command -ComputerName $Computer -Scriptblock { Get-CimInstance -ClassName Win32_NetworkAdapter | Select-Object Name, AdapterType, ServiceName }
                                                
                            $AdaptersData = foreach ($Adapter in $AllAdapters) {
                                [PSCustomObject]@{
                                    nName        = $Adapter.Name
                                    nAdapterType = $Adapter.AdapterType
                                    nServiceName = $Adapter.ServiceName
                                }
                            }

                            $AdaptersColumns = @(
                                New-UDTableColumn -Property nName -Title "Name" -IncludeInExport -IncludeInSearch
                                New-UDTableColumn -Property nAdapterType -Title "Type" -IncludeInExport -IncludeInSearch
                                New-UDTableColumn -Property nServiceName -Title "Service namne" -IncludeInExport -IncludeInSearch
                            )
                            if ($null -eq $AdaptersData) {
                                New-UDAlert -Severity 'error' -Text "Could not read any data, try again!"
                                Break
                            }
                            else {
                                New-UDTable -Id 'AdapterSearchTable' -Data $AdaptersData -Columns $AdaptersColumns -Sort -ShowSearch -ShowPagination -Dense -Export -ExportOption "xlsx, PDF" -PageSize 20 -PageSizeOptions @(30, 40, 50)
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

Export-ModuleMember -Function "Get-NetAdp"