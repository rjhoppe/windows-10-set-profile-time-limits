## Description

A how-to guide on how to safely lock and/or log yourself out of your Windows machine at a reasonable time to make sure you go to bed!

## Services Used:
* Windows PowerShell
* Windows Command Prompt
* Windows Task Scheulder
* My Lockbox (not required)

## Configuring Logon Hours Allowed For Windows User Account

First, you want to set your account login timeframe. You can do this by launching Command Prompt as an Administrator. Now type in:

net user {your username}

This will show you information currently associated with your Windows user profile. If you previously set a login timeframe, it will be displayed here.

By default, you should see "Logon hours allowed: All"

To change your logon hours allowed, type the command below:

net user {your username} /times:{First Day}-{Last Day},hh:mm-hh:mm

Here's an example of a time frame that would work:

net user Johnny /times:M-F,10:00-22:00;Sa-Su,09:00-23:00

This command would allow the user Johnny to login to this machine from 10 AM - 10 PM , Monday - Friday and from 9 AM - 11 PM on Saturday and Sunday

Note: Windows abbreviates days of the week by their first two letters when applicable. These are the proper abbreviations for all the days of the week
* Sunday = Su
* Monday = M
* Tuesday = Tu
* Wednesday = W
* Thursday = Th
* Friday = F
* Saturday = Sa

You should see "The command completed successfully"  after you press Enter/Retun. If you see an error, check these elements of your command:
* Ensure that you have "times" and not "time" in your command
* Ensure that you are using proper abbreviations
* Ensure that your times are set in full hour increments
* Ensure that have a semi-colon (;) to denote separate time frames

Now try the "net user {your username}" command again and you should see the time frame you set returned to you in the "Logon hours allowed"

If you see "None" the command did not properly set and your user account does not have permission to initiate a new login on your machine.

You can use "net user {your username} /times: all" to give full login access permissions to a user account.

