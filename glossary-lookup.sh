# Run from a folder containing a folder for each language you want to look up a word in, 
# with the contents of the glossaries from https://developer.apple.com/download/more/?=glossaries
#
# Prints the all translations found for the given word in each language, along with how many occurrences of that translation were found.
#
# Dependencies
# brew install xmlstarlet
#
# Usage
# 
# glossary-lookup.sh Print
#
# Example Output:
# French
# -------------------
#    8 Imprimer

# German
# -------------------
#    8 Drucken

# Russian
# -------------------
#    5 Напечатать
#    3 Печать

for language in */ ; do
	echo ""
	echo "${language%%/}"
	echo "-------------------"

	cd "$language"
	echo "" > temp.txt

    for file in *.lg;
	do
		xmlstarlet sel -t -v "//base[@loc='en' and text()='$1']/../tran" $file >> temp.txt
		echo "" >> temp.txt
	done

	sed -i '' '/^[[:space:]]*$/d' temp.txt
	sort temp.txt | uniq -c | sort -bgr
	rm temp.txt

	cd ..
done

echo ""
