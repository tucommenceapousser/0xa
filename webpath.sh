#!/bin/bash

# Fonction pour rechercher les chemins web
search_paths() {
    read -p "Entrez le domaine ou le chemin à rechercher: " target

    echo -e "\nRecherche des chemins web pour $target\n"

    # Ajoutez ici vos commandes pour la recherche des chemins web
    paths=$(find / -type f \( -name "*.php" -o -name "*.html" -o -name "*.js" -o -name "*.css" -o -name "*.aspx" \) -exec dirname {} + 2>/dev/null)

    # Affiche les résultats
    if [ -n "$paths" ]; then
        echo -e "\nChemins trouvés:\n$paths"
    else
        echo -e "\nAucun chemin trouvé pour $target"
    fi
}

# Interface colorée et interactive
echo -e "\n\033[1;36mBienvenue dans le chercheur de chemins web interactif!\033[0m"
search_paths
