## Description

A how-to guide on how to safely lock and/or log yourself out of your Windows machine at a reasonable time to make sure you go to bed!

## Services Used:
* Windows PowerShell
* Windows Command Prompt
* Windows Task Scheulder

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

After setting account logon hours, if a user tries to login outside of the specified time frame, they will receive a login error that says:

"Your account has time restrictions that prevent you from signing in at this time. Please try again later."

## Creating your Windows PowerShell Logout Script

In the previous step, we have prevented a user from logging in before or after specific times. But what if they are already logged in?

We now need to create a script to forcibly logout a user at a certain time. To make sure he or she goes to bed! 

You can create a simple PowerShell script or .bat file to do this for you. It might look something like this:

shutdown -r -f -t 01

This is a very simple script that when activated will initiate a logoff and restart procedure on your machine.

If you wanted to get fancy, you could do something like this:

$Day = Get-Date -Format "dddd MM/dd/yyyy HH:mm K"

if ($Day -like "*Friday*" -or $Day -like "*Saturday*") {
   Write-Host "No action at this time because it is the weekend" -ForegroundColor Green
}
else {
   shutdown -r -f -t 03
}

This pulls the date and time from the system and checks the day of the week. If the day of the week is Friday or Saturday, the script is not run (in case you want to be kind to yourself and allow for some fun on the weekends!)

Now we have our script ready to go, but now we need something to trigger it, that is where Windows Task Scheduler comes into play.

Let's save our script file to our desktop before proceeding.

## Configuring Windows Task Scheduler

Task Scheduler is an application that comes with a standard Windows 10 install. It allows you to schedule certain events to be run at a particular time (our use case) or when a specific trigger event happens with basic UI interface.

Let's go ahead and create a new task. Name it something like "Daily Scheduled Logoff" or something to that effect.

In our new event, let's create a new trigger. 

For this new trigger, let's configure it to run "Daily" and at specific time (mine is set to 9:30 PM).

Next, we want to set an event that our task will run when the trigger condition is reached. Select the "Start a Program" option and then browse for our .ps1 or .bat script file that we created in the previous step.

Finalize your new task by saving.

Nice work! You now have a new task that will forcibly logout a user from their account when the trigger time is reached.

The last step is to test our task. You can initiate a manual run of your new task by right clicking on the task then selecting "Run."

If your task is properly configure, the system should log you out of your account and restart your machine.

Congrats! You have set up guardrails to make sure you get off your computer at a reasonable time and GET TO BED! :)
