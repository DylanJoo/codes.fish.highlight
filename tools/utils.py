import json
import collections

def read_fin10k(path):
    """
    Returns:
        data_sorted: dictionary of sent pair information of a `List`.
    """
    data = collections.defaultdict(list)

    with open(path, 'r') as f:
        for i, line in enumerate(f):
            idA, idB, sentA, sentB = line.strip().split('\t')

            data[f'{idA}#{idB}'] = {
                    "idB": idB,
                    "idA": idA,
                    "sentA": sentA,
                    "sentB": sentB
            }

    # sanity check
    n_pairs = len(data)
    n_sentB = len(set([id_pair.split('#')[1] for id_pair in data.keys()]))
    print(f"Total number of exampels: {len(data)}")
    assert n_pairs == n_sentB, 'Mismtach number of {n_pairs} and {n_sentB}'

    # sort by idb if using evaluation ser
    data_sorted = [v for k, v in sorted(data.items(), key=lambda x: x[0])]
    return data_sorted

def token_extraction(srcA, srcB, pair_type=2):
    tokensA = srcA.split()
    tokensB = srcB.split()

    labelsA = [0] * len(tokensA)
    probsA = labelsA
    # we only focus on highlight sentB
    if pair_type == 2:
        labelsB = [1] * len(tokensB)
    else:
        labelsB = [pair_type] * len(tokensB)
    probsB = labelsB

    return {'type': int(pair_type),
            'sentA': srcA, 'sentB': srcB,
            'words': ["<tag1>"] + tokensA + ["<tag2>"] + tokensB + ["<tag3>"],
            'wordsA': tokensA, 'wordsB': tokensB,
            'keywordsA': [], 'keywordsB': [],
            'labels': [-1] + labelsA + [-1] + labelsB + [-1],
            'probs': [-1] + probsA + [-1] + probsB + [-1],}

def load_pred(file_path, special_token=False, prob_threshold=0):
    """
    Returns:
        dict_pred: dictionary of pair id and its prediction.
    """
    prediction = {}
    with open(file_path, 'r') as f:
        for i, line in enumerate(f):
            data = json.loads(line)
            try:
                pair_id = data.pop('idA') + "#" + data.pop('idB')
            except:
                pair_id = i

            prediction[pair_id] = []

            flag = False
            for j, (w, p) in enumerate(zip(data['words'], data['probs'])):

                if p == -1:
                    # when aggregation
                    if special_token:
                        prediction[pair_id].append( (w, p) )
                        flag = True
                    # when evaluation
                    else:
                        flag = False if j == 0 else True
                elif flag:
                    if p >= prob_threshold:
                        prediction[pair_id].append( (w, p) )
                    else:
                        prediction[pair_id].append( (w, 0) )
                else:
                    pass

    return prediction
