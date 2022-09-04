echo 'start' > log/fin10k.data.aggreagate.log

for FILE in fin10k-results/*/ITEM*.type2.pred;do
    OUTPUT_FILE=${FILE/\.pred/}
    if [ -s $FILE ]
    then
        # FILE=${FILE##*fin10k-demo/}
        echo $OUTPUT_FILE
        python3 tools/aggregate_highlight.py \
          -pred ${FILE} \
          -out ${OUTPUT_FILE} \
          -thres -1  >> log/fin10k.data.aggreagate.log
    else
        echo File $FILE empty
        mkdir -p ${OUTPUT_FILE%/*}
        touch $OUTPUT_FILE
        echo Create empty file and skip processing.
    fi
done
