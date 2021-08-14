# Description
With this dashboard you can upload files that then are presented in the dashboard.
In this example every UDCard shows the content from a folder.

* **Pages**
    - showpage.ps1  
    Lists the uploaded files in UDCards and the user can download the files
    - delpage.ps1  
    Shows UDModal that let you delete files from the uploaded folder
    - uploadpage.ps1  
    Shows UDModal that let you upload selected file

# System Requirements
Beside the System Requirements that are listed in the "main" README.md file you also need the following for this dashboard
* Service account that are running PowerShell Universal service on the host need to have the proper premissions to delete, create and change files in the upload folder.

# Setup
## Do on the host
1. You need to create the correct folders for my example the folders are located in D:\Upload\ but you can change that if you want.
2. Download the hole Upload Dashboard folder from this Repo and then copy it to; C:\ProgramData\UniversalAutomation\Repository
3. Import a new Dashboard in the PowerShell Universal Admin, put down the searchpath to the folder and the Dashboard.ps1 like this: C:\ProgramData\UniversalAutomation\Repository\Upload-Dashboard\Dashboard.ps1

## showpage.ps1
1. You need to change the folder path in the variables at the top of the page $folder1 - $folder4 change D:\Upload\Folder1 to the correct path for your folders that you want to show in the dashboard. You can also change the name of the variables if you want that.
2. Here you can set the name of the card, change 'Folder 1' to whatever you want to name the card.
3. You need to change "EXAMPLE" in this "https://EXAMPLE/Folder1/$1Doc" to yours.

## delpage.ps1

## uploadpage.ps1

# Secure
I can recommend you to make some kind of security for the upload and delete page.  
In my example below it limit the page so only the choosen roles can open the page.  

if ($Roles -notin @('ROLE1', 'ROLE2').ForEach{ $PSItem -in $Roles }) {  
    New-UDErrorBoundary -Content {  
        throw "You don't have permissions to access this page!"  
        Break  
    }  
}  
else {  
    ## YOURPAGE  
}  