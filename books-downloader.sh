
OUTDIR=issues

if [ ! -d "$OUTDIR" ]; then
 mkdir "$OUTDIR"
fi


file="special-editions.txt"
while IFS= read -r line
do
	bash <(curl https://raw.githubusercontent.com/joergi/downloader/master/linux_mac/downloader.sh) $line	
done < "$file"

exit 0
