vzp_logger
==========

Windows Command Line Assessment Logging Utility (batch file)

this is a simple and extensible batch file that records command line events in a log, and records the command line output in a separate file.

Currently it is hard coded to save the output to c:\assessment.  It is easily changed in the .bat and I may add the input line to set it when you start it.

Basic use:
Just run the .bat file. 
It asks a few questions about the test type, the name of the tester, and the customer/asset name.
You then get a basic command prompt.  Run whatever you need and it will be recorded for you.

If you need to change testers, just type 'user <new name>' and that gets logged and now commands are attributed to the new user.

If you need to log an event that wasn't run from the command prompt, like a vulnerability scan or exploit,
just type 'log <event description>'

When you are completely finished, just type exit.

You can have multiple instances open with no issues.

days, weeks, or months later when you need to go back and see who did what and the output it is there.

Just trying something quickly and later realize you need that command switch or didn't redirect the output you needed, there it is.

Don't need it at all later?  Delete the files.
