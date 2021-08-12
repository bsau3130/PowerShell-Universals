# This modal are setting the correct apptoken dependning on what's your hostname is.
# You need to fill out the variables below to get it to work, for more information read the README.md file.

$Host1 = ""         # Write the one hostname here
$Host1Token = ""    # Write your token for host1
$Host2 = ""         # Write the other hostname here
$Host2Token = ""    # Write your token for host2

function Get-AppToken {
    # Collect the current hostname on the server where PowerShell Universal are running on.
    $CurrentHostName = [System.Net.Dns]::GetHostName()

    if ($CurrentHostName -eq $Host1) {
        [PSCustomObject]@{
            CurrentAppToken = $Host1Token
        }
    }
    elseif ($CurrentHostName -eq $Host2) {
        [PSCustomObject]@{
            CurrentAppToken = $Host2Token
        }
    }
}

Export-ModuleMember -Function "Get-AppToken"