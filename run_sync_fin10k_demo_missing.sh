for PATH_COM in fin10k-missing-data/*;do
    COM=${PATH_COM##*/}
    # for PATH_FILE in fin10k-missing-data/${COM}/*.pred;do
    #     FILE=${PATH_FILE##*/}
    #     ORIG=${PATH_FILE/fin10k-missing-data/fin10k-results}
    #     MISSING=${PATH_FILE}
    #     # wc -l $MISSING
    #     # wc -l $ORIG
    #     cat $MISSING >> $ORIG
    # done
    for PATH_FILE in fin10k-missing-data/${COM}/*.type0;do
        ORIG=${PATH_FILE/fin10k-missing-data/fin10k-results}
        MISSING=${PATH_FILE}
        cat $MISSING >> $ORIG
        # wc -l $ORIG
        # wc -l $MISSING
    done
    for PATH_FILE in fin10k-missing-data/${COM}/*.type1;do
        ORIG=${PATH_FILE/fin10k-missing-data/fin10k-results}
        MISSING=${PATH_FILE}
        cat $MISSING >> $ORIG
        # wc -l $ORIG
        # wc -l $MISSING
    done
done
