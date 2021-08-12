# Description
Here I do publish some random module / Components that I have done for PowerShell Universal.

# List of module / Components
* AppToken
    - Autoselect the correct AppToken depending on the hostname, perfect for load balancing.
* InstalledSW
    - List all installed softwares from remote Windows client.
* rmUserProfile
    - List all user profiles from remote Windows client, also let's you delete profiles.
* NetAdp
    - Lists all of the installed networkscard from a remote Windows client.
* InstalledDrivers
    - Lists all installed drivers from a remote Windows client.

# System requirements
All of the module / Components are tested with the following setup and are needed to get it to work. It should work with older version of Windows but I can't guarantee it.
* Windows Server 2019
* Windows 10 20H2
* PowerShell Universal 2.2.1

# How do I install the module / Components?
1. Download the module / Components and move/copy the folder to "C:\ProgramData\PowerShellUniversal\Dashboard\Components"
2. Restart the Powershelluniversal services in Task Manager.
3. Enter the Admin console for Powershell universal and add this component to your dashboard
4. Don't know if this is necessary but I use to restart the PowerShell Universal service once again.