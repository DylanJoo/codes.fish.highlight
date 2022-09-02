import os
import collections
import argparse
import json

def separate_by_id(args):
    com_item_collections = collections.defaultdict(list)

    with open(args.path_input_file, 'r') as fin:
        for line in fin:
            data_jsonl = json.loads(line.strip())
            com_id, _, item_id, _, _ = data_jsonl['idB'].split('_')
            com_item_collections[f"fin10k-missing-data/{com_id}/{item_id.upper()}.type{args.file_type}"].append(
                    json.dumps(data_jsonl) + '\n'
            )
    return com_item_collections
    
def reallocate_examples(com_item_collections):

    for path_output_file in com_item_collections:

        # path_output_folder = path_output_file.rsplit('/')[0]
        os.makedirs(os.path.dirname(path_output_file), exist_ok=True)
        print(f"{path_output_file}")

        with open(path_output_file, 'w')  as fout:
            fout.writelines(com_item_collections[path_output_file])

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    # For all data
    parser.add_argument("-input", "--path_input_file", type=str)
    parser.add_argument("-type", "--file_type", type=str)
    args = parser.parse_args()

    # os.makedirs(os.path.dirname(args.path_output_file), exist_ok=True)
    missing_collections = separate_by_id(args)
    reallocate_examples(missing_collections)

    print("Done")
