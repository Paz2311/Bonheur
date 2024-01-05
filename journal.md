# Bonheur

### Groupe :

- AUGUSTYN Patricia (Sorbonne Nouvelle)
- BOTERO Maria (Nanterre)
- SKRZYNIARZ Agata (INALCO)

## Séance du 22 novembre 2022

### Agata :
Au cours du développement du script de table pour le polonais, j'ai rencontré un obstacle lié à la complexité de la grammaire polonaise. En effet, il existe des conjugaisons de cas pour les noms en polonais, ce qui n'est pas le cas en français et en espagnol. Par conséquent, trouver le nombre d'occurrences du mot "szczęście" est plus compliqué car il faut prendre en compte non seulement toutes les conjugaisons du nom. Mais aussi, les conjugaisons de ce nom sont sans caractères polonais, car beaucoup de gens ne les utilisent pas, surtout sur des sites tels que les forums où le style d'écriture est plutôt informel. En conséquence, j'ai dû envisager huit possibilités afin de trouver le plus grand nombre possible de contextes liés à ce mot.

### Patricia :
Cette séance a eu pour but de commencer notre projet. Au cours de la séance, nous avons accompli plusieurs tâches :
- créer notre dépôt Git : https://github.com/Paz2311/Bonheur
- commencer à créer notre arborescence en fonction des exercices réalisés
- sauvegarder les pages aspirées
- sauvegarder les dumps textuels

Ensuite, nous nous sommes reunis au cours de la semaine pour pouruivre le projet, notamment en travaillant sur la créations du tableau HTML. Pour cela, nous avons :
- ajouté des colonnes au fur et à mesure des exercices réalisés en cours et chez nous
- continué le comptage des occurrences de notre mot "bonheur"
- recherché les contextes gauche et droit de notre mot à l'aide des fonctions -B et -A de grep

### Maria :
Le travail en groupe s'est très bien passé. On a décidé de faire les push depuis l'ordinateur de Patricia pour éviter des problèmes. On a décidé de tout classer dans des dossiers et changer chaque script séparemment. Je pense qu'on travaille bien en groupe du fait qu'on s'entraide bien.

On a fait une réunion en groupe, aujourd'hui, dimanche 26 novembre. J'ai eu des problèmes avec mon script du fait que il y avait seulement 7 liens qui s'affichaient et je ne réussissais pas à le changer. On a pris le modèle de script de Patricia, qui était le plus complète et qui avait tous les chemins relatifs qu'on avait utilisé dans notre scprit en cours. On a travaillé ensemble pour résoudre les problèmes de git-hub d'Agata et on appris qu'on ne peut pas modifier des documents, les enregistrer sur notre machine et après faire git-pull. On pensait cela à partir des explications du cours.

### Discussion en groupe :

Pendant le cours, une question s'est immédiatement posée : comment organiser nos documents ? Nous avons eu une arborescence proposé par nos professeurs, mais cela nous a un peu perturbé. En étant des personnes maniaques de l'organisation, nous souhaitions avoir des dossiers et fichiers structuré et bien triés.
Pour cela, nous avons décidé d'ajouter des sous-dossiers pour chaque langue, accompagnés de fichiers correspondant à la langue. Ainsi, nous avons décidé d'anticiper l'avancée de notre projet. Par exemple, il sera plus simple pour nous de travailler individuellement sur notre langue respective et de mieux nous repérer.

De plus, nous avons longuement discuté de l'exercice 5 parce que le concordancier sera un élément primordial dans l'analyse du mot. Cependant, c'est un outil difficile à mettre en place.

## Séance du 29 novembre 2022

### Agata :

En explorant iTrameur, j'ai rencontré quelques difficultés et je n'arrivais pas à me repérer sur le site. J'ai également trouvé que la complexité de la langue polonaise nécessitait un peu plus de travail. Ainsi, le nombre d'occurrences d'un mot n'est pas très clair car un mot peut être conjugué de 7 manières différentes. Par conséquent, il est plus difficile de trouver les mots qui reviennent le plus souvent dans le contexte du bonheur, car ils sont divisés par cas. Cependant, en tapant au moins le début du mot, j'ai pu trouver plus d'occurrences du même mot.

### Patricia :
Cette séance avait pour objectif de poursuivre notre projet. Au cours de la séance, nous avons accompli plusieurs tâches :
- corriger les exercices
- améliorer nos scripts, si nécessaire
- introduction sur le logiciel iTrameur : https://itrameur.clillac-arp.univ-paris-diderot.fr/

Pour la prochaine séance, nous devons créer un concordancier en créant une page HTML pour chaque lien, puis l'ajouter à notre tableau. De plus, cela nous a permis de déployer notre site web afin de mieux visualiser le rendu, mais aussi de prendre de l'avance sur la fin du projet.

Concernant le français, le déploiement du concordancier s'est révélé complexe en raison du sujet portant sur les forums. Ainsi, les fichier .txt reprennent la forme du site, donc les retours à la ligne. Lorsque nous avons tenté de reprendre la correction minimale pendant le cours, cela  a entraîné la suppression de nombreuses occurrences et des manques de contextes à droit ou à gauche. En effet, j'ai amélioré la regex en prenant en compte toutes les dérivaison du mot "bonheur".

De plus, concernant le script iTrameur, les pages sont désordonnées car nous avons observé que lorsque elles étaient dans l'ordre, les "body" ne correspondaient pas au numéro de page. Par exemple, <page="fr_01"> n'avait pas le contenu de fr_01 mais de fr_10.
De plus, pour le français, la fin de la page est ajoutée deux fois. Voici, ce que l'on retrouve :
...
© Ligue contre le cancer 2023
   Pied de page
     * Plan du site
     * Mentions légales
/page §</text>
</page> §

Malgrés nos efforts, nous ne comprenons pas pourquoi cela fait ça. Par ailleurs, pendant l'analyse sur iTrameur, cela ne nous a pas posé de problème parce que cela n'affectait  pas les résultats. Le seul problème est que dans les cadres, cela ajoute des cadres avec seulement le symbole §.

### Maria :
Personnellement, j'ai eu des problemes au momment d'utiliser la commande vue en cours pours construire le concordancier. J'ai essayé d'utiliser cette commande et c'est celle qui a montré les meilleurs résultats. C'est pour cette raison que nous avons utilisé le code :
     while IFS= read -r line;
        do
            matches=($(grep -o -P "${MOT}" <<< "$line"))
            for match in "${matches[@]}";
            do
                echo "<tr><td>${line%%$match*}</td><td>$match</td><td>${line#*$match}</td></tr>">>
            done
        done < "$file"
Par rapport à iTrameur, je trouve cette plateforme hyper intéressante et outile pour le traitement de corpus.

### Discussion en groupe :
Ce devoir a été difficile, non pas en raison de la complexité de l'exercice en tant que lui, mais parce que nous avons la sensation que les instructions n'étaient pas claires. Nous n'avons pas compris s'il fallait faire un document .txt avec tous les contextes des trois langues, mais à la fin on a en a fait seulement un avec tous les contextes par langue. Aussi, nous n'avons pas très bien compris dans quel format il fallait rendre les analyses issues d'iTrameur ou quelles étaient les caractéristiques de cette analyse. C'est pour cette raison que nous avons commencé à faire un pdf avec l'analyse de chaque langue que nous continuerons à développer si c'est le cas.


## Séance du 06 décembre 2022

### Agata :

Au cours de cette semaine j'ai décidé de continuer à travailler sur mon analyse iTrameur. La première difficulté que j'ai rencontrée a été le fait qu'après avoir cliqué sur l'icône Ventilation sur le mot "szczęście", le graphique montrant le nombre d'occurrences de ce mot dans tous les documents n'apparaissait pas. Cependant, après un certain temps, j'ai réalisé que la raison en était que dans l'onglet Paramètres, j'avais sélectionné "lang" dans l'onglet Partition au lieu de "page". Après avoir modifié cette option, j'ai vu les graphiques corrects que j'ai utilisés pour mon analyse.

### Patricia :
Cette séance avait pour objectif de poursuivre notre projet. Au cours de la séance, nous avons accompli plusieurs tâches :
- consacré une partie du cours à la correction de nos scripts
- discuté sur les projets en cours
Nous avons également exploré la fascinante technique des nuages de mots, un outil qui a suscité un vif intérêt au sein du groupe. Notre site web a un visuel du ciel avec des nuages, et où j'avais comme objectif de créer ce nuage de mot en forme de nuage.

Ainsi, j'ai pu faire l'analyse d'itrameur, en format balise, et intégrer des nuages de mots pertinents pour enrichir notre compréhension du sujet. Ces moments d'échange et de collaboration ont renforcé notre cohésion en tant que groupe et ont ouvert de nouvelles perspectives passionnantes pour nos travaux à venir.

### Maria :
Nous avons mieux compris le rôle des script PALS  dans notre projet et nous avons décidé de les intégrer dans notre projet pour améliorer l'apparition des coocurrents. Pour l'instant, je travaille pour approfondir mon analyse itrameur et ajouter l'étymologie du mot "felicidad", en espagnol.  Même si ce mot ne présente des diacritiques qui pourraient générer des problèmes dans l'analyse de iTrameur, les signes de ponctuation ¿¡ entrainent un nouveau mot qui n'apparaît pas si on tape seulement le mot "felicidad".

## Dernier commentaire

### Agata :

Pendant les vacances de Noël, nous avons procédé à la dernière étape de la finalisation de notre projet. Chacun d'entre nous a effectué une analyse indépendante des corpus dans nos langues respectives. Dans mon analyse, j'ai décidé d'inclure les outils iTrameur tels que le dictionnaire, la ventilation, la concordance, la cocurrence, ainsi que le nuage de mots et le script PALS. Lors de notre dernière réunion, nous avons rédigé un paragraphe avec une conclusion générale.

### Patricia :
Pendant le dernier cours, plusieurs idées nous sont venues à l'esprit. Nous avons voulu faire un script Python pour nos langues, mais aussi intégrer un nuage de mots à notre site. Pendant les vacances, nous avons terminé nos analyses en utilisant divers logiciels, tels que iTrameur, Wordcloud et PALS. Mais aussi, nous avons réussi à mettre toutes les pièces du puzzle ensemble et finaliser ce projet.

### Maria :
Créer le corpus a été vraiment difficile, je n'arrivais pas a créer le corpus pours les script PALS.Tous les problèmes étaient liés à la regex que j'ai utilisé. J'ai dû créer trois scripts différents pour chaque langue. Il y avait des caractères qui ne s'affichaient pas en polonais car ils étaient encodés dans deux encodages différents, chose que malheuresement j'ai pas pu résoudre, parce que ce même caractère s'affichait bien dans d'autres mots. J'ai ajouté ma partie de l'ánalyse du wordcloud et mon analyse des résultats du concordancier PALS.

Je suis très contente avec le résultat de notre projet.




