f1base=${1##*/}
f1pref=${f1base%.*}
f1path=${1%/*}
f1ext=${f1base##*.}

bmtools/bmtagger/bmtagger.sh -b bmtools/bmtagger/hs37.bitmask -x bmtools/bmtagger/hs37.srprism -T bmtools/bmtagger/tmp -q1 -1 $1 -o ${1}.contaminants.txt

python remove_contamination.py -f $1 -c ${1}.contaminants.txt

f1pref="${f1pref}_no_contamination"
f1="${f1path}/${f1pref}.${f1ext}"

java -jar trimmomatic-0.33.jar SE -threads 1 $f1 ${f1path}/${f1pref}_trimmed.${f1ext} LEADING:3 TRAILING:3 MINLEN:50
