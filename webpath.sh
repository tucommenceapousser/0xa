#!/bin/bash

# Fichier de sortie
output_file="web_paths.txt"

# Fonction pour rechercher les chemins web
search_paths() {
    echo -e "\nRecherche des chemins web...\n"

    # Ajoutez ici vos commandes pour la recherche des chemins web
    paths=$(find / -type f \( -name "*.php" -o -name "*.html" -o -name "*.js" -o -name "*.css" -o -name "*.aspx" \) -exec dirname {} + 2>/dev/null)

    # Affiche les résultats
    if [ -n "$paths" ]; then
        echo -e "\nChemins trouvés:\n$paths"
        echo -e "$paths" > "$output_file"
        echo -e "\nChemins enregistrés dans $output_file"
    else
        echo -e "\nAucun chemin trouvé."
    fi
}

# Interface colorée et interactive
echo -e "\n\033[1;36mBienvenue dans le chercheur de chemins web!\033[0m"
search_paths
