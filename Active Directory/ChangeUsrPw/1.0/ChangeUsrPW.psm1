function New-ChangeUsrPW {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)][string]$UserName
    )
    Show-UDModal -Header { "Change password for $($UserName)" } -Content {
        New-UDRow -Columns {
            New-UDColumn -SmallSize 6 -LargeSize 6 -Content {
                New-UDTextbox -id "txtpw1" -Label 'New password' -Type password
            }
            New-UDColumn -SmallSize 6 -LargeSize 6 -Content {
                New-UDTextbox -id "txtpw2" -Label 'Re-type password' -Type password
            }
        }
        New-UDRow -Columns {
            New-UDColumn -SmallSize 6 -LargeSize 6 -Content {
                New-UDCheckBox -id "chckpwchange" -Label 'Change the password at the next login?' -LabelPlacement start
            }
        }
    } -Footer {
        New-UDButton -Text "Change" -Size medium -OnClick {
            $PW1 = (Get-UDElement -Id "txtpw1").value
            $PW2 = (Get-UDElement -Id "txtpw2").value
            $chckpwchange = (Get-UDElement -Id 'chckpwchange').checked

            if ([string]::IsNullOrEmpty($pw1) -or [string]::IsNullOrEmpty($pw2)) {
                Show-UDToast -Message "You have failed to fill in one box, fill in both boxes and try again!" -MessageColor 'red' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                Break
            }
            elseif ($pw1.length -lt 8) {
                Show-UDToast -Message "The password is too short, you must enter at least 8 characters!" -MessageColor 'red' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
            }
            else {
                if ($PW1 -eq $PW2) {
                    try {
                        Set-ADAccountPassword -Identity $UserName -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $PW1 -Force)
                        if ($chckpwchange -eq "True") {
                            Set-ADUser -Identity $UserName -ChangePasswordAtLogon $true
                        }
                        Show-UDToast -Message "$($UserName) password has changed!" -MessageColor 'green' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                        Hide-UDModal
                    }
                    catch {
                        Show-UDToast -Message "$($PSItem.Exception)" -MessageColor 'red' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                        Break
                    }
                }
                else {
                    Show-UDToast -Message "The password are not a match, try re-typing it again!" -MessageColor 'red' -Theme 'light' -TransitionIn 'bounceInUp' -CloseOnClick -Position center -Duration 2000
                    Break 
                }
            }
        }
        New-UDButton -Text "Close" -Size medium -OnClick {
            Hide-UDModal
        }
    } -FullWidth -MaxWidth 'md' -Persistent
}

Export-ModuleMember -Function "New-ChangeUsrPW"