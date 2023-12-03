#!/usr/bin/env bash

#lignes permettant la vérifications des arguments :
if [ $# -ne 1 ]
then
	echo "un argument attendu exactement"
	exit
else

if [ ! -f ../URLs/$1 ]
	then
		echo "le fichier n'existe pas"
		exit
	fi
fi

#construction des variables utile dans la construction de notre tableau, le premier argument est le fichier texte d'urls:
URLS=$1
lineno=1

#construction du début du fichier html avec les métadonnées :
echo "<html>
	<head>
		<meta charset="UTF-8"/>
		<title>Tableau</title>
		<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css\">
		<style>

            table {
                box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.8);
            }

            tr {
                transition: all .2s ease-in;
                cursor: pointer;
            }

            tr:hover {
                background-color: #ace0f9;
                transform: scale(1.01);
            }
        </style>
	</head>
	</head>
	<body>"


echo "
		<div class=\"content m-3\">
			<table class=\"table is-bordered\">
				<tr>
                    <th>Ligne</th>
                    <th>URL</th>
                    <th>Code HTTP</th>
                    <th>Encodage</th>
                    <th>Aspiration</th>
                    <th>Dump-text</th>
                    <th>Compte</th>
                    <th>Contexte</th>
                    <th>Concordancier</th>
                    </tr> "



#remplissage du tableau html :
while read -r URL
do
    #lang=$(basename $URLS .txt)
	reponse=$(curl -s -I -L -w "%{http_code}" -o "../aspirations/espagnol/esp_${lineno}.html" $URL)
	encodage=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
	aspirations=$(curl -o "../aspirations/espagnol/esp_${lineno}.html" $URL)
	dump=$(lynx -dump -nolist $URL > "../dumps-text/espagnol/esp_${lineno}.txt")
	compte=$(lynx -dump "../dumps-text/espagnol/esp_${lineno}.txt" | tr '[:space:]' '\n' | grep -i -o "felicidad" | wc -l)

	contexte=$(grep -B 1 -A 1 -i "felicidad" "../dumps-text/espagnol/esp_${lineno}.txt")

    # Sauvegarder les contextes en .txt et en les nommant
    echo "$contexte" > "../contextes/espagnol/esp_${lineno}.txt"

	echo "				<tr>
					<td>$lineno</td>
					<td>$URL</td>
					<td>$reponse</td>
					<td>$encodage</td>
					<td><a href=\"../aspirations/espagnol/esp_${lineno}.html\">esp_${lineno}.html</a></td>
					<td><a href=\"../dumps-text/espagnol/esp_${lineno}.txt\">esp_${lineno}.txt</a></td>
					<td>$compte</td>
					<td><a href='../contextes/espagnol/esp_${lineno}.txt'>esp_${lineno}.txt</a></td>
					<td><a href='../concordances/espagnol/esp_${lineno}.html'>esp_${lineno}.html</a></td>
				</tr>"
	lineno=$(expr $lineno + 1)
done < ../URLs/$URLS

#fermetures du tableau avec les balises fermantes html :
echo "
			</table>
		</div>
	</body>
</html>"

#bash ./tableaux_esp.sh fr.txt > ../tableaux/tableaux_esp.html


