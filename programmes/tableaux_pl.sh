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
        <link href='https://fonts.googleapis.com/css2?family=Abel&family=Bad+Script&display=swap' rel=\"stylesheet\">
        <style>
            html{
                background: #FAF0E6;
            }

            body {
                font-family: Abel;

            }

            p {
                font-size : 20px;
            }

            table {
                box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.8);
            }

            tr {
                transition: all .2s ease-in;
                cursor: pointer;
            }

            tr:hover {
                color: #FBFFFF;
                background-color: black;
                transform: scale(1.01);
            }
        </style>
	</head>
	<body>"


echo "
			 <div class=\"content m-3\">
				<h1 class=\"has-text-centered notification has-background-warning-light\">Résultat du tableau</h1>
				<p>Voici le résultat final du tableaux. Pour cela vous trouverez : </p>
				<ul>
					<li>Le numéro de la ligne</li>
					<li>Le lien URL de la page web</li>
					<li>Le code HTTP, c'est-à-dire la réponse du navigateur lorsque l'utilisateur se trouve sur le site</li>
					<li>L'encodage de la page</li>
					<li>Le lien des pages aspirées au format HTML</li>
					<li>Le lien des dumps-text en .txt</li>
					<li>Le nombre d'occurrences</li>
					<li>Le contexte droit et gauche en .txt</li>
				</ul>
				<table class=\"table is-bordered\">
				<tr>
                    <th>Ligne</th>
                    <th>URL</th>
                    <th>Code HTTP</th>
                    <th>Encodage</th>
                    <th>Aspiration</th>
                    <th>Dump-text</th>
                    <th>Compte</th>
                    <th>Contexte</th></tr> "



#remplissage du tableau html :
while read -r URL
do
    #lang=$(basename $URLS .txt)
	reponse=$(curl -s -I -L -w "%{http_code}" -o "../aspirations/polonais/pl_${lineno}.html" $URL)
	encodage=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
	aspirations=$(curl -o "../aspirations/polonais/pl_${lineno}.html" $URL)
	dump=$(lynx -dump -nolist $URL > "../dumps-text/polonais/pl_${lineno}.txt")
	compte=$(lynx -dump "../dumps-text/polonais/pl_${lineno}.txt" | tr '[:space:]' '\n' | egrep "szczęście|szczęścia|szczęściu|szczęściem|szczescie|szczescia|szczesciu|szczesciem" -wc)

	contexte=$(grep -B 1 -A 1 -i "szczęście|szczęścia|szczęściu|szczęściem|szczescie|szczescia|szczesciu|szczesciem" "../dumps-text/polonais/pl_${lineno}.txt")

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



