echo "Createing data for bert...(demo)" > fin10k.demo.dat 

PATH_MISSING_FILES_DEMO=/tmp2/yshuang/fintext/new-data/demo.missing.pairs.type

echo -e > log/fin10k.data.parse.log
for PATH_FILE in ${PATH_MISSING_FILES_DEMO}*;do

    # for PATH_FILE in ${PATH_COM}/*;do
    FILE=${PATH_FILE##*/}
    OUTPUT_FILE=fin10k-data/missing/$FILE
    echo 'PROCESSING [FILE] '${PATH_FILE} 

    # 1) convert to jsonl
    python3 tools/convert_text_to_jsonl.py \
        -input $PATH_FILE \
        -output $OUTPUT_FILE \
        -type ${FILE##*type} \
        -nosep >> log/fin10k.missing.data.parse.log

    # 2) filter out the overlength, if type == 2 
    # [NOTE] Overlength pair would be putted into type1
    if [[ "$PATH_FILE" = *type2* ]]; then
        python3 tools/filter_overlength_pair.py \
          -in $OUTPUT_FILE  >> log/fin10k.missing.data.parse.log &
    fi
done
