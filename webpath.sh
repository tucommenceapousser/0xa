#!/bin/bash

# Fichier de sortie
output_file="web_paths.txt"

# Fonction pour rechercher les chemins web
search_paths() {
    echo -e "\n\033[1;34mRecherche des chemins web...\033[0m"

    # Ajoutez ici vos commandes pour la recherche des chemins web
    paths=$(find / -type f \( -name "*.php" -o -name "*.html" -o -name "*.js" -o -name "*.css" -o -name "*.aspx" \) -exec dirname {} + 2>/dev/null)

    # Affiche les résultats
    if [ -n "$paths" ]; then
        echo -e "\n\033[1;32mChemins trouvés:\033[0m\n$paths"
        echo -e "$paths" > "$output_file"
        echo -e "\n\033[1;32mChemins enregistrés dans $output_file\033[0m"
    else
        echo -e "\n\033[1;31mAucun chemin trouvé.\033[0m"
    fi
}

# Mesure du temps d'exécution
start_time=$(date +%s)

# Interface colorée et interactive
echo -e "\n\033[1;36mBienvenue dans le chercheur de chemins web!\033[0m"
search_paths

# Mesure du temps d'exécution
end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo -e "\n\033[1;35mTemps d'exécution: $execution_time secondes\033[0m"
