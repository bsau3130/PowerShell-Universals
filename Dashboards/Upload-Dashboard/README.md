

# Description
With this dashboard you can upload files that then are presented in the dashboard.
In this example every UDCard shows the content from a folder.

**Here is a video that are showing how it works. I have pre-uploaded some files to speed the recording up.**  
(When I was clicking on the FileZilla file it did download to the client but as I did cut my display during the recording you did not see the download grafic)  
![Demo Video](https://user-images.githubusercontent.com/76907327/129473665-9b0d21a6-419f-4add-b98c-489fff5b58bc.mp4)


* **Pages**
    - showpage.ps1  
    Lists the uploaded files in UDCards and the user can download the files
    - uploadpage.ps1  
    Shows UDModal that let you upload selected file
    - Delpage.ps1
    Shows UDModal where you can delete a file.

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
1. Here you need to change the folderpath to the correct folderpath at the correct varibles.
2. Here you write your domain to the host.
3. Here you can set the name of the card, change 'Folder 1' to whatever you want to name the card.
4. Depending on what name/url you have on the published folder you need to change this part to match yours "/Upload/Folder1/"

## uploadpage.ps1
1. Here you write the path to the root upload folder of your choose, for me it's D:\Upload and under that folder my card folders are located.

## Delpage.ps1
1. Here you write the path to the root upload folder of your choose, for me it's D:\Upload and under that folder my card folders are located.

# Secure
I can recommend you to make some kind of security for the upload and delete page.
In my example below it limit the page so only members of ROLE1 and ROLE2 can see them.  

if ($Roles -notin @('ROLE1', 'ROLE2').ForEach{ $PSItem -in $Roles }) {  
    New-UDErrorBoundary -Content {  
        throw "You don't have permissions to access this page!"  
        Break  
    }  
}  
else {  
    ## Delete / add button code
}  
