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
 mkdir "$OUTDIR"
fi

downloadUrl="https://wireframe.raspberrypi.org/issues/%02d/pdf"

file="$BASEDIR/sources-for-download/regular-issues.txt";
recentIssue=$(cat "$file");

# workaround for a known limitation in bash 3.x: http://lists.gnu.org/archive/html/bug-bash/2006-01/msg00018.html
# stackoverflow: https://stackoverflow.com/questions/32596123/why-source-command-doesnt-work-with-process-substitution-in-bash-3-2/32596626#32596626
# shellcheck disable=SC1091
source /dev/stdin <<<"$(curl -s https://raw.githubusercontent.com/joergi/downloader/main/linux_mac/downloader.sh)" "$downloadUrl" "$OUTDIR" "$recentIssue" "$@"

exit 0

