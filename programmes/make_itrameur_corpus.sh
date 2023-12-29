FOLDER=$1 # le dossier d'une langue que nous allons traiter
lang=$2 # par exemple en, fr, ch, jp

echo "<lang=\""$lang"\">" > "./itrameur/$FOLDER-en.txt"

for filename in $(ls "$FOLDER/$lang");
do

    page=$(basename $filename .txt)
    content=$(cat $FOLDER/$lang/$filename)
    cleaned=$(echo $content | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g' | tr -d "§") # remplacer les symboles < > &
    echo "<page="$page">"
    echo "<text>"
    echo $cleaned
    echo "</text>"
    echo "</page> §"
    page_number=$(expr $page_number + 1)

done >> "./itrameur/$FOLDER-en.txt"

echo "</lang>" >> "./itrameur/$FOLDER-en.txt"