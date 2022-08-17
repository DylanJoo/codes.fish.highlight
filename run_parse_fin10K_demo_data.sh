echo "Createing data for bert...(demo)" > fin10k.demo.dat 

PATH_DEMO=/tmp2/yshuang/fintext/new-data/demo/

echo -e > log/fin10k.data.parse.log
for PATH_COM in ${PATH_DEMO}/*;do
    COM=${PATH_COM##*/}

    for PATH_FILE in ${PATH_COM}/*;do
        FILE=${PATH_FILE##*/}
        OUTPUT_FILE=fin10k-data/$COM/$FILE

        # CASE 1: Valid file
        if [ -s $PATH_FILE ]
        then
            echo 'PROCESSING [COMPANY] '${PATH_COM##*/} '[FILE] '${PATH_FILE##*/} 

            # 1) convert to jsonl
            python3 tools/convert_text_to_jsonl.py \
                -input $PATH_FILE \
                -output $OUTPUT_FILE \
                -type ${FILE##*type} \
                -nosep >> log/fin10k.data.parse.log

            # 2) filter out the overlength, if type == 2 
            # [NOTE] Overlength pair would be putted into type1
            if [[ "$PATH_FILE" = *type2* ]]; then
                python3 tools/filter_overlength_pair.py \
                  -in $OUTPUT_FILE  >> log/fin10k.data.parse.log &
            fi
        # CASE 2: Empty file
        else
            echo 'EMPTY FILE FOUND [COMPANY] '${PATH_COM##*/} '[FILE] '${PATH_FILE##*/}
            mkdir -p fin10k-data/${COM}
            touch $OUTPUT_FILE
            echo Create empty file and skip processing.
        fi
    done
done
