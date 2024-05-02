#!/bin/bash
############################################################################## 
#                                                                            #
#	SHELL: !/bin/bash       version 1.4                                      #
#									                                         #
#	NOM: BEUGNET							                                 #
#									                                         #
#	PRENOM: Thierry							                                 #
#									                                         #
#	DATE: 19/04/2024	           				                             #
#									                                         #
#	BUT: Script pour nettoyer les sauvegarde AB                 		     #
#									                                         #
############################################################################## 
DATE=$(date "+%y%m%d_%H%M")
LOG=savcleaner.txt
DOSSIERLOGS="C:/Users/thierry/Documents/logs/" #a modifier si besoin
DIRLOGAB="C:\ProgramData\AomeiBR\brlog.xml"
#DIRLOGAB="brlog.xml"
HOST=$(hostname | tr a-z A-Z) # Récupère le hostname et le transforme en majuscules
#HOST=$(echo $HOST | tr a-z A-Z)
LECTEUR=$"H:" # Mettre la lettre de votre lecteur de sauvegarde sur votre ordinateur
#LECTEUR=$"./test" 
NBSAV=1 #Nb de sauvegarde complètes à conserver

if [ ! -d $DOSSIERLOGS ];then
echo "Création du dosser LOGS !";
mkdir $DOSSIERLOGS
fi

touch "$DOSSIERLOGS"$DATE"$LOG"
#traitement du fichier log, retire les lignes et balises inutiles
cat $DIRLOGAB | tr -d " " |  sed '/^<?/d' | sed '/^<BR*/d'| sed '/^<Log*/d' | sed '/^<\/Log>/d' | sed '/^<ResultCode>/d' | sed '/^<Detail*/d'| sed '/^<\/BRLog>/d' | tr '\r' ' '  > INTER1
sed -i 's/<\/Time>//g;s/<\/Operation>//g;s/<\/Task>//g;s/<Time>//g;s/<Task>/;/g;s/<Operation>/;/g;s/<Result>/;/g' INTER1

cat INTER1 | tr -d "\n" | tr -d " " > INTER2
sed -i 's/<\/Result>/\n/g' INTER2
tac INTER2 | sed '/complète/!d;/'Succès/!d > INTER3 #ne conserve que les sav complètes et réussies

#va chercher les dossiers de sauvegardes pour les traiter 1 par 1
NBL=$(ls -lh $LECTEUR/ | grep ^d | grep "$HOST"$ | wc -l) 
for (( c=1; c<=$NBL; c++ ))
do
BACKUP=$(ls -lh $LECTEUR/ | grep ^d | grep "$HOST"$ | tr -s " "| cut -d " " -f9 | head -$c | tail +$c)
echo "Dossier de sauvegarde : ${BACKUP}" | tee -a "$DOSSIERLOGS"$DATE"$LOG"
#va chercher les sauvegardes complètes réussis en fonction du nb à conserver (le log est par défaut dans l'ordre chono)
NBL2=$(cat INTER3 | grep "$BACKUP" | head -$NBSAV | tail +$NBSAV | wc -l)
for (( d=1 ; d<=$NBL2 ; d++  ))
do
LINE=$(cat INTER3 | grep "$BACKUP")
#transforme la date du format timestamp à un format exploitable
TIME0=`echo $LINE | cut -d ";" -f1`
TIME=`date -d "@$TIME0" +%Y%m%d`
SAUVEGARDE=`echo $LINE | cut -d ";" -f2`
TYPESAV=`echo $LINE | cut -d ";" -f3`
OK0PASOK1=`echo $LINE | cut -d ";" -f4`
#echo "${TIME};${SAUVEGARDE};${TYPESAV};${OK0PASOK1}" >> brlog.csv
echo "La dernière sauvegarde complète date de : ${TIME}" | tee -a "$DOSSIERLOGS"$DATE"$LOG"

#cherche les fichiers plus anciens que la date des logs (le -newer est pour identifier les fichiers plus récents mas le ! permet de l'inverser)
NBFILES=$(find "$LECTEUR"/"$BACKUP"/ -type f ! -newerBt $TIME | wc -l)
if [ $NBFILES -gt 0 ]
then
echo "Il y a $NBFILES fichiers à supprimer" | tee $DATE$LOG
find "$LECTEUR"/"$BACKUP"/ -type f ! -newerBt $TIME | tee -a "$DOSSIERLOGS"$DATE"$LOG"
find "$LECTEUR"/"$BACKUP"/ -type f ! -newerBt $TIME -exec rm {} \;
echo "Suppression terminée" | tee -a "$DOSSIERLOGS"$DATE"$LOG"
else
echo "aucun fichier à supprimer" | tee -a "$DOSSIERLOGS"$DATE"$LOG"
fi
done
done
#suppression des fichiers temporaires
rm INTER*
sleep 60