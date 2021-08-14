# List of module / Components

# System Requirements
Beside the System Requirements that are listed in the "main" README.md file you also need the following for this Modules / Components.
* VMware PowerCLI 12.3.0
* PowerCli Example modules

# How you install the needed modules for PowerShell on the host
1. Download VMware PowerCLI 12.3.0
    - https://code.vmware.com/web/tool/12.3.0/vmware-powercli
2. Download PowerCli Example modules
    - https://github.com/vmware/PowerCLI-Example-Scripts
3. Move the PowerCli Example modules and VMware PowerCLI 12.3.0 to "C:\Program Files\WindowsPowerShell\Modules"
4. Start PowerShell as Administrator
5. Write "Get-ChildItem -Path 'C:\Program Files\WindowsPowerShell\Modules' -Recurse | Unblock-File" press enter.