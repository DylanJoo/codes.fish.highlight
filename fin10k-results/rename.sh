for com in *;do
    for file in $com/*jsonl;do
        mv ${file} ${file/jsonl/pred}
    done
done
