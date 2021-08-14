# Description
This module / Components adds a button. On click opens a window where you can change the users password, you can also selecet so they user need to change it by them self at the next login.
I have set so you can't choose a password that are shorter then 8 characters, if you want to change that you can change it at row 30.

# How to call the function
Your calling on the function in the following way, you can put the code insida a button or what ever.
* UserName, the username of the user that you want to change the expiration date for.

New-ChangeUsrPW -UserName "YOURUSER"