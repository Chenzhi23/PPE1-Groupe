dossier=$1 # le dossier d'une langue que nous allons traiter
langnom=$2 # par exemple en, fr, ch, jp
page_number=1

echo "<lang=\""$langnom"\">" > "../itrameur/contextes-jp.txt"

for page_number in {1..50};
do
    fichier=$dossier/fich-anglais-$page_number.txt
    if [ -f $fichier ];
    then
        echo "<page=\"$langnom-$page_number\">"
        echo "<text>"
        cat $fichier | sed -e 's/&/\&amp/g' -e 's/</\&lt/g' -e 's/>/\&gt/g' | tr -d "§" # remplacer les symboles < > &
        echo "</text>"
        echo "</page> §"
        page_number=$(expr $page_number + 1)
    else
        echo "Il n'y a pas ce fichier."
    fi
done >> "../itrameur/contextes-jp.txt"

echo "</lang>" >> "../itrameur/contextes-jp.txt"
