# Description
This modal shows a list of all the installed softwares from a selected remote client.

# Special requirements
Make sure that the user that runs the PowerShellUniversal services on the host has the proper premissions.

# How to call the function
Your calling on the function in the following way, you can put the code insida a button or what ever.
* OUClient, it's the path in your AD where you have all of your clients
* Computer, this is the name/hostname of the client that you want to list the profiles from.

Get-InstalledSW -OUClient "ADPATHTOCLIENTS" -Computer "YOURCLIENTNAME"