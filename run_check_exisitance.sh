for PATH_COM in fin10k-missing-data/*;do
    COM=${PATH_COM##*/}
    for PATH_FILE in ${PATH_COM}/*;do
        FILE=${PATH_FILE##*/}

        if [ -s ${PATH_FILE/fin10k-missing-data/fin10k-data} ]
        then
            echo 'EXISTED FILE '${PATH_FILE/fin10k-missing-data/fin10k-data}
            wc -l ${PATH_FILE}
            wc -l ${PATH_FILE/fin10k-missing-data/fin10k-data}
        else
            echo 'EMPTY FILE '${PATH_FILE} 
        fi
    done
done
