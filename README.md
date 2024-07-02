The purpose of this script is to cleanup the Aomei Backupper's saves directory (works on tech edition 6.8.0)
it deletes all backup files older than the number of full backups defined in configuration 

This script was release in TSSR studies and works on windows via git for windows.
I don't know if it can run on linux operating system, i didn't test it.

<b>######CONFIGURATION###########################################################</b><br>
DATE=$(date "+%y%m%d_%H%M")<br>
LOG=savcleaner.txt <b>#name for scripts logs</b><br>
DOSSIERLOGS="C:/SCRIPTS LOGS DIRECTORY/"<b>#path for script logs</b><br>
DIRLOGAB="C:\ProgramData\AomeiBR\brlog.xml"<b>#directory of Aomei logs</b><br>
HOST=$(hostname | tr a-z A-Z) <br>
LECTEUR=$"H:" <b>#disk where aomei' saves are </b> (can be a directory but the structure must be : disk or directory with (sub)directories only with aoemi saves) <br>
NBSAV=1 #<b>set the number of complete saves that you whant to keep</b><br>
<b>######CONFIGURATION###########################################################</b><br>

<b>You can use the windows's tasks scheduler (for me at 9am every day) </b>

![image](https://github.com/u2pitchjami/clean_sav_tssr6/assets/149841209/49c8338c-422f-4f43-ab49-e7c6b4c247c5)
