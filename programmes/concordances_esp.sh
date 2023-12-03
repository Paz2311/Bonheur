#!/usr/bin/env bash

MOT="[Ff][Ee][Ll][Ii][Cc][Ii][Dd][Aa][Dd]:?,?" #\W

for file in ../contextes/espagnol/esp_*.txt;
do
    lineno=$(echo "$file" | sed -E 's/.*esp_([0-9]+)\.txt/\1/')
    OUTPUT_FILE="../concordances/espagnol/esp_${lineno}.html"

    # construction du début du fichier html avec les métadonnées
    echo "<html>
        <head>
            <meta charset=\"UTF-8\">
            <title>Concordancier FR</title>
            <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css\">
            <style>
                table {
                    box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.8);
                    color : white;
                }
                tr {
                    transition: all .2s ease-in;
                    cursor: pointer;
                }
                tr:hover {
                    background-color: white;
                    color : black;
                    transform: scale(1.01);
                }
            </style>
        </head>
        <body>
            <div class=\"content m-3\">
                <h1 class=\"title is-1 has-text-centered has-background-info-dark has-text-white-bis\">Concordancier du français</h1>
                <div class=\"table-container\">
                    <table class=\"table is-bordered has-background-info-dark has-text-white-bis\">
                        <tr>
                            <th>Gauche</th><th>Mot</th><th>Droite</th>
                        </tr>" > "$OUTPUT_FILE"

    #grep -o -i -P "(\S+\s*){0,9}${MOT}(\s*\S+){0,9}" "$file" | sed -E "s/(.*)(${MOT})(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" >> "$OUTPUT_FILE"
    #grep -o -i -P "(\w+\W+){0,9}${MOT}(\W\w+){0,9}" "$file" | sed -E "s/(.*)(${MOT})(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" >> "$OUTPUT_FILE"
     #chercher les contextes à l'aide de regex : malheureusement les 2 n'était pas performante, ainsi on a du chercher sur internet :
     while IFS= read -r line;
        do
            matches=($(grep -o -P "${MOT}" <<< "$line"))
            for match in "${matches[@]}";
            do
                echo "<tr><td>${line%%$match*}</td><td>$match</td><td>${line#*$match}</td></tr>" >> "$OUTPUT_FILE"
            done
        done < "$file"


    # ajout de la fermeture du fichier html
    echo "                    </table>
                </div>
            </div>
        </body>
    </html>" >> "$OUTPUT_FILE"
done
