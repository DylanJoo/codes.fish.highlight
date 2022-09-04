for PATH_COM in fin10k-data/*;do
    COM=${PATH_COM##*/}
    for PATH_FILE in fin10k-data/${COM}/*.type0;do
        FROM=${PATH_FILE}
        RESULT=${PATH_FILE/fin10k-data/fin10k-results}
        cat $FROM >> $TO
        # wc -l $FROM
        # wc -l $RESULT
    done
    for PATH_FILE in fin10k-data/${COM}/*.type1;do
        FROM=${PATH_FILE}
        RESULT=${PATH_FILE/fin10k-data/fin10k-results}
        cat $FROM >> $TO
        # wc -l $FROM
        # wc -l $RESULT
    done
done
