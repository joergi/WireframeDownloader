#!/bin/bash
# ------------------------------------------------------------------
# [Author] joergi - https://github.com/joergi/WireframeDownloader
#          downloader for all Wireframe magzine issues
#          based on Magpi Downloader: https://github.com/joergi/MagpiDownloader
#          they are downloadable for free under https://wireframe.raspberrypi.org/issues
#          or you can buy the paper issues under: https://store.rpipress.cc/collections/wireframe
#          this script is under GNU GENERAL PUBLIC LICENSE 3
# ------------------------------------------------------------------

# VERSION=0.1.0
# USAGE="Usage: bash wireframe-downloader.sh [-f firstissue] [-l lastissue]"

BASEDIR=$(dirname "$0")
OUTDIR=$BASEDIR/issues

if [ ! -d "$OUTDIR" ]; then
 mkdir $OUTDIR
fi

i=1
file="$BASEDIR/regular-issues.txt";

issues=$(cat "$file");

	while :
	do
		case "$1" in
		-f) shift; i="$1";;
		-l) shift; issues="$1";;
		--) shift; break;;
		-*) usage "bad argument $1";;
		*) break;;
		esac
		shift
	done

	while [ "$i" -le "$issues" ]
	do
		printf -v page_url "https://wireframe.raspberrypi.org/issues/%02d/pdf" "$i"
		pdf_url=$(curl -sf "$page_url" | grep \"c-link\" | sed 's/^.*href=\"//' | sed 's/\?.*$//')
		wget -N "$pdf_url" -P "$OUTDIR"
		i=$(( i+1 ))
	done

exit 0
