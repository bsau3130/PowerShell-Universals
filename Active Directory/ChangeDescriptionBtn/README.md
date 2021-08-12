# Description
This module / Components adds a button that then open a pop-up window (UDModal) where you can change the AD description for either group, user or computer depending on what you have choosen. The UDModal is also pre-populated with the current ad description.

# How to call the function
This function is little special or well according to me it's perfect. Anyway.. Depending on what you have choosen for ChangeDescriptionObject you add the -ComputerName or -UserName or -GroupName when you call the function.
* ChangeDescriptionObject, Here can you choose Compure, User or Group depending on what you want to change the description on.
* CurrentValue, If you want to show what the current descpriton is.
* UserName, Name of the user you want to change the description of if you have choosen user in ChangeDescriptionObject
* ComputerName, Name of the computer you want to change the description of if you have choosen computer in ChangeDescriptionObject
* GroupName, Name of the group you want to change the description of if you have choosen group in ChangeDescriptionObject

Example;

New-ChangeDescriptionBtn -ChangeDescriptionObject "UserName" -CurrentValue $CurrentDescription -UserName $CollectUserName

New-ChangeDescriptionBtn -ChangeDescriptionObject "ComputerName" -CurrentValue $CurrentDescription -ComputerName $CollectComputerName 