# Description
This module / Components unlock the selected AD account if it's locked.
You can add this function to a button or similar.

# How to call the function
Your calling on the function in the following way, you can put the code insida a button or what ever.
* UserName, the username you want to unlock
* OUUsr, it's the path in your AD where you have all of your Users

New-UnlockADUsr -UserName "USERYOUWANTTOUNLOCK" -OUUsr "ADPATHTOUSERS"