for file in fin10k-data/missing/*;do
    python3 tools/break_down_company.py \
        -input ${file} \
        -type ${file##*type}
done
