function New-UnlockADUsr {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)][string]$UserName,
        [Parameter(Mandatory)][string]$OUUsr
    )

    $ADuser = Get-ADUser -Filter "samaccountname -eq '$UserName'" -SearchBase $OUUsr -Properties lockedout

    if ($ADuser.lockedout -eq $true) {
        try {
            Unlock-ADAccount -Identity $UserName
            Show-UDToast -Message "The account are now unlocked!" -MessageColor 'green' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
        }
        catch {
            Show-UDToast -Message "$($PSItem.Exception)" -MessageColor 'red' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
            Break
        }
    }
    else {
        Show-UDToast -Message "The account was not locked, no changes has been done!" -MessageColor 'Red' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
        Break
    }
}

Export-ModuleMember -Function "New-UnlockADUsr"