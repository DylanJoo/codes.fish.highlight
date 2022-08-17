export CUDA_VISIBLE_DEVICES=2
BS=16

python3 inference.py \
  --model_name_or_path checkpoints/esnli-zs-highlighter/checkpoint-12500/ \
  --config_name bert-base-uncased \
  --eval_file fin10k-data/1001250/ITEM1.type2 \
  --output_file test.jsonl \
  --remove_unused_columns false \
  --max_seq_length 512 \
  --per_device_train_batch_size $BS \
  --do_eval \
  --prob_aggregate_strategy max

# done
# for COM in fin10k-data/*;do
#     for FILE in ${COM}/ITEM*.type2;do
#         if [ -s $FILE ]
#         then
#             python3 inference.py \
#               --model_name_or_path checkpoints/esnli-zs-highlighter/checkpoint-12500/ \
#               --config_name bert-base-uncased \
#               --eval_file $FILE \
#               --result_json $FILE.pred \
#               --remove_unused_columns false \
#               --max_seq_length 512 \
#               --per_device_train_batch_size $BS \
#               --do_eval \
#               --prob_aggregate_strategy max
#         fi
#     done
# done
