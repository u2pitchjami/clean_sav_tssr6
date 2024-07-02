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
