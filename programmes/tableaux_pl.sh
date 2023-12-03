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
	reponse=$(curl -s -I -L -w "%{http_code}" -o "../aspirations/polonais/pl_${lineno}.html" $URL)
	encodage=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
	aspirations=$(curl -o "../aspirations/polonais/pl_${lineno}.html" $URL)
	dump=$(lynx -dump -nolist $URL > "../dumps-text/polonais/pl_${lineno}.txt")
	compte=$(lynx -dump "../dumps-text/polonais/pl_${lineno}.txt" | tr '[:space:]' '\n' | egrep "szczęście|szczęścia|szczęściu|szczęściem|szczescie|szczescia|szczesciu|szczesciem" | wc -l)

	contexte=$(grep -B 1 -A 1 -i "\(szczęście\|szczęścia\|szczęściu\|szczęściem\|szczescie\|szczescia\|szczesciu\|szczesciem\)" "../dumps-text/polonais/pl_${lineno}.txt")

    # Sauvegarder les contextes en .txt et en les nommant
    echo "$contexte" > "../contextes/polonais/pl_${lineno}.txt"

	echo "				<tr>
					<td>$lineno</td>
					<td>$URL</td>
					<td>$reponse</td>
					<td>$encodage</td>
					<td><a href=\"../aspirations/polonais/pl_${lineno}.html\">pl_${lineno}.html</a></td>
					<td><a href=\"../dumps-text/polonais/pl_${lineno}.txt\">pl_${lineno}.txt</a></td>
					<td>$compte</td>
					<td><a href='../contextes/polonais/pl_${lineno}.txt'>pl_${lineno}.txt</a></td>
					<td><a href='../concordances/polonais/pl_${lineno}.html'>pl_${lineno}.html</a></td>
				</tr>"
	lineno=$(expr $lineno + 1)
done < ../URLs/$URLS

#fermetures du tableau avec les balises fermantes html :
echo "
			</table>
		</div>
	</body>
</html>"

#bash ./tableaux_pl.sh pl.txt > ../tableaux/tableaux_pl.html



