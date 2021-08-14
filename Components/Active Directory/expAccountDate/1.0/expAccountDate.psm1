function New-expAccountDate {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)][string]$UserName
    )
    Show-UDModal -Header { "Change the expiration date for $($UserName)" } -Content {
        New-UDRow -Columns {
            New-UDColumn -SmallSize 6 -LargeSize 6 -Content {
                New-UDDatePicker -id "pickDate" -Format "yyyy-MM-dd"
            }
        }
    } -Footer {
        New-UDButton -Text "Submit" -Size medium -OnClick {
            $NewDate = (Get-UDElement -Id "pickDate").value
            try {
                Set-ADAccountExpiration -Identity $UserName -DateTime $NewDate
                Show-UDToast -Message "$($UserName) expiration date has been changed to $($NewDate)" -MessageColor 'green' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                Hide-UDModal
            }
            catch {
                Show-UDToast -Message "$($PSItem.Exception)" -MessageColor 'red' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                Break
            }
        }
        New-UDButton -Text "Close" -Size medium -OnClick {
            Hide-UDModal
        }
    } -FullWidth -MaxWidth 'xs' -Persistent
}

Export-ModuleMember -Function "New-expAccountDate"