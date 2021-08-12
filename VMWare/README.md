# Description
Here I do publish VMWare (vSphere, ESXi, Horizon, DEM) module / Components that I have done for PowerShell Universal.

# List of module / Components


# System requirements
All of the module / Components are tested with the following setup and are needed to get it to work. It should work with older version of Windows but I can't guarantee it.
* VMware PowerCLI 12.3.0
* PowerCli Example modules
* Windows Server 2019
* Windows 10 20H2
* PowerShell Universal 2.2.1

# How you install the needed modules for PowerShell on the host
1. Download VMware PowerCLI 12.3.0
    - https://code.vmware.com/web/tool/12.3.0/vmware-powercli
2. Download PowerCli Example modules
    - https://github.com/vmware/PowerCLI-Example-Scripts
3. Move the PowerCli Example modules and VMware PowerCLI 12.3.0 to "C:\Program Files\WindowsPowerShell\Modules"
4. Start PowerShell as Administrator
5. Write "Get-ChildItem -Path 'C:\Program Files\WindowsPowerShell\Modules' -Recurse | Unblock-File" press enter.


# How do I install the module / Components?
1. Download the module / Components and move/copy the folder to "C:\ProgramData\PowerShellUniversal\Dashboard\Components"
2. Restart the Powershelluniversal services in Task Manager.
3. Enter the Admin console for Powershell universal and add this component to your dashboard
4. Don't know if this is necessary but I use to restart the PowerShell Universal service once again.