# Description
This modal are opening a new window that lists all user profiles on selected remote client and also let's you delete the profile if needed.

**The following profiles are excluded and are not listed**
* C:\Users\Administratör
* C:\Users\Administrator

# Special requirements
Make sure that the user that runs the PowerShellUniversal services on the host has the proper premissions to delete folders etc. from the remote clients.

# How to call the function
Your calling on the function in the following way, you can put the code insida a button or what ever.
* ReplaceDomain, this is the start of your domain for example if your domain are "example.se" then your write "example" only.
* OUClient, it's the path in your AD where you have all of your clients
* Computer, this is the name/hostname of the client that you want to list the profiles from.

Remove-UserProfiles -ReplaceDomain "YOURDOMAIN" -OUClient "ADPATHTOCLIENTS" -Computer "YOURCLIENTNAME"