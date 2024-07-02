The purpose of this script is to cleanup the Aomei Backupper's saves directory (works on tech edition 6.8.0)

This script was realase in TSSR studies and works on windows via git for windows.
I don't know if it can run on linux operating system, i didn't test it.

######CONFIGURATION###########################################################<br>
DATE=$(date "+%y%m%d_%H%M")<br>
LOG=savcleaner.txt 
DOSSIERLOGS="C:/SCRIPTS LOGS DIRECTORY/" #a modifier si besoin
DIRLOGAB="C:\ProgramData\AomeiBR\brlog.xml" #dossier log Aomei
HOST=$(hostname | tr a-z A-Z) # Récupère le hostname et le transforme en majuscules
LECTEUR=$"H:" # Mettre la lettre de votre lecteur de sauvegarde sur votre ordinateur
NBSAV=1 #Nb de sauvegarde complètes à conserver
######CONFIGURATION###########################################################
