# Description
With this dashboard you can upload files that then are presented in the dashboard.
In this example every UDCard shows the content from a folder.

* **Pages**
    - showpage.ps1  
    Lists the uploaded files in UDCards and the user can download the files
    - uploadpage.ps1  
    Shows UDModal that let you upload selected file

# System Requirements
Beside the System Requirements that are listed in the "main" README.md file you also need the following for this dashboard
* Service account that are running PowerShell Universal service on the host need to have the proper premissions to delete, create and change files in the upload folder.

# Setup
## Do on the host / PowerShell Universal Admin page
1. You need to create the correct folders for my example the folders are located in D:\Upload\ but you can change that if you want.
2. Download the hole Upload Dashboard folder from this Repo and then copy it to; C:\ProgramData\UniversalAutomation\Repository
3. Import a new Dashboard in the PowerShell Universal Admin, put down the searchpath to the folder and the Dashboard.ps1 like this: C:\ProgramData\UniversalAutomation\Repository\Upload-Dashboard\Dashboard.ps1
4. You also need to allow access to the upload folder in PowerShell Universal Admin under Platform -> Published Folders in my example the path is D:\Upload

## showpage.ps1  
(I have only written explanations for the first card, it's the same for the rest!)
1. Here you need to change the folderpath to the correct folderpath at the correct varibles.
2. Here you write your domain to the host.
3. Here you can set the name of the card, change 'Folder 1' to whatever you want to name the card.
4. Depending on what name/url you have on the published folder you need to change this part to match yours "/Upload/Folder1/"


# Secure
I can recommend you to make some kind of security for the upload and delete icon/button.  
In my example below it limit the button so only members of ROLE1 and ROLE2 can see them.  

if ($Roles -notin @('ROLE1', 'ROLE2').ForEach{ $PSItem -in $Roles }) {  
    New-UDErrorBoundary -Content {  
        throw "You don't have permissions to access this page!"  
        Break  
    }  
}  
else {  
    ## Delete / add button code
}  