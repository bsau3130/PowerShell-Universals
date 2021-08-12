# Description
Many of use are using multiple PowerShell Universal hosts as we need to Loadbalance or just have some redundancy.
So I have done a modal for PowerShell Universal that are changing the AppToken depending on what host your script will run.

This is simple solution but it works and get's the job done!

If you want to use it with more hosts then two then just add an other elseif or use switch or something like that. Don't forget to add more variables $Host3 and $Host3AppToken

# How to use it
In your dashboard add the following variabels in the topp.

$GetAppToken = Get-AppToken

$AppToken = $GetAppToken.CurrentAppToken

What this does is that it check what host your on, then it adds the correct AppToken to the variable $AppToken depending on what host your on.