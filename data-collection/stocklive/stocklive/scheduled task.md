# Setting up a cron job in Windows

The windows equivalent to a cron job is a scheduled task.

A scheduled task can be done command line with schtasks (if you for instance need to script it or add it to version control).

An example:

```schtasks /create /tn calculate /tr calc /sc weekly /d MON /st 06:05 /ru "System"```  

Creates the task calculate, which starts the calculator(calc) every monday at 6:05 (should you ever need that.)

All available commands can be found here: http://technet.microsoft.com/en-us/library/cc772785%28WS.10%29.aspx

[1]: https://stackoverflow.com/questions/7195503/setting-up-a-cron-job-in-windows