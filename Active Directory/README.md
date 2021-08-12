# Description
Here I do collect some module / Components that are good to have to administrate Active Directory trough PowerShell Universal.

# List of module / Components
* expAccountDate
    - Shows a window where you can change the expiration date of the users ad-account.
* ChangeDescriptionBtn
    - Adds button that will let you change the AD description of the Computer, User or Groupobject depending on what you chooses.
* UnlockADUsr
    - Unlock the selected AD account if it's locked
* ChangeUsrPw
    - Adds button, on-click it's open a Window where you can change the password for the AD User, you can also force the user to change it by them self at the next login.

# System requirements
All of the module / Components are tested with the following setup and are needed to get it to work. It should work with older version of Windows but I can't guarantee it.
* Service account that are running PowerShell Universal service on the host need to have the proper premissions for Active Directory.
* Active Directory Module installed on the host
* Active Directory Module imported to your Dashboard
* Windows Server 2019
* Windows 10 20H2
* PowerShell Universal 2.2.1

# How do I install the module / Components?
1. Download the module / Components and move/copy the folder to "C:\ProgramData\PowerShellUniversal\Dashboard\Components"
2. Restart the Powershelluniversal services in Task Manager.
3. Enter the Admin console for Powershell universal and add this component to your dashboard
4. Don't know if this is necessary but I use to restart the PowerShell Universal service once again.