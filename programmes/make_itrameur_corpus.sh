#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Il faut 3 arguments : le chemin du dossier dumps-txt, le chemin du dossier contextes et la langue"
    exit 1
fi

dossier_dump="$1"
dossier_context="$2"
lang="$3"

output_dump="itrameur/dumps-text_${lang}.txt"
echo "<lang=\"${lang}\">" > "$output_dump"

output_context="itrameur/contextes_${lang}.txt"
echo "<lang=\"${lang}\">" > "$output_context"

# Parcours de tous les fichiers du dossier dump
for fichier in "$dossier_dump"/"${lang}"_*.txt; do
    if [ -f "$fichier" ]; then

       # Extraction du numéro de page à partir du nom du fichier
		page=$(basename "$fichier" .txt)

       # Suppression des &<>
        texte=$(cat "$fichier" | tr -d '&<>')

        # Ajout des balises au fichier de sortie
        echo "<page=\"${page}\">" >> "$output_dump"
        # Substitution des caractères spéciaux xml dans le texte

       #echo "<text>$(sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g' "$fichier")</text>" >> "$output"
       #Attention : pour le français cela rajoute quand même une balise fermante </page> § en plus (juste avant </texte>)
        echo "<text>${texte}</text>" >> "$output_dump"
        echo "</page> §" >> "$output_dump"
    fi
done
echo "</lang>" >> "$output_dump"


# Parcours de tous les fichiers du dossier context
for fichier in "$dossier_context"/"${lang}"*.txt; do
    if [ -f "$fichier" ]; then

        # Extraction du numéro de page à partir du nom du fichier
		page=$(basename "$fichier" .txt)

        # Suppression des &<>
        texte=$(cat "$fichier" | tr -d '&<>')

        # Ajout des balises au fichier de sortie
        echo "<page=\"${page}\">" >> "$output_context"

        #echo "<text>$(sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g' "$fichier")</text>" >> "$output_context"
        echo "<text>${texte}</text>" >> "$output_context"
        echo "</page> §" >> "$output_context"
    fi
done
echo "</lang>" >> "$output_context"


#Attention ce script est à lancer depuis le dossier principale et non du programmes :
#exemple : ./programmes/make_itrameur_corpus.sh ./dumps-text/francais/ ./contextes/francais/ fr
