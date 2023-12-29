#!/usr/bin/env zsh


dossier=$1
lang=$2


chemin_output=../itrameur/$dossier-$lang.txt




echo "<lang=\"$lang\">">$chemin_output




for nb in {1..50}
#将 for 循环的范围用 {1..50} 替换了 range(1, 51)。在 Bash 中，可以使用花括号表示法来生成数字范围。
do
    fichier=./../$dossier/$lang/$(basename ../$dossier"-text"/$lang/$lang-$nb.txt)
    contenu=$(cat $fichier | sed -E 's/&/&amp;/g' | sed -E 's/</&lt;/g' | sed -E 's/>/&gt;/g')
    # sed 后面需要接 单引号 而不是双引号，否则会什么来着？     
    #sed一直报错sed: RE error: illegal byte sequence
    echo "<page=\"$lang-$nb\">
<text>
$contenu
</text>
</page>§">>$chemin_output
done



echo "</lang>">>$chemin_output


