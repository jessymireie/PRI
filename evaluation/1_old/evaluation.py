# SETUP
import matplotlib.pyplot as plt
from sklearn.metrics import PrecisionRecallDisplay
import numpy as np
import json
import requests
import pandas as pd

QRELS_FILE = "1/qrels1.txt"
QUERY_URL = "http://localhost:8983/solr/races_schema/query?q=race_text:youngest%20race_text:driver%20race_text:win&q.op=AND&indent=true&rows=18"

# Read qrels to extract relevant documents
relevant = list(map(lambda el: el.strip(), open(QRELS_FILE).readlines()))
print(relevant)
# Get query results from Solr instance
results = requests.get(QUERY_URL).json()['response']['docs']

TOTAL = 2268
TP = 0
FP = 0
FN = 0
TN = 0 # TO FILL

for result in results:
    if(result['raceId'] in relevant):
        print("TP:", result['raceId'])
        TP += 1
    else:
        print("TN:", result['raceId'])
        FP += 1

FN = len(relevant) - TP
TN = TOTAL - (TP + FP + FN)

# -------------------------------------------------------------------------------------

# METRICS TABLE
# Define custom decorator to automatically calculate metric based on key
metrics = {}
metric = lambda f: metrics.setdefault(f.__name__, f)

@metric
def ap(results, relevant):
    """Average Precision"""
    precision_values = [
        len([
            doc 
            for doc in results[:idx]
            if doc['raceId'] in relevant
        ]) / idx 
        for idx in range(1, len(results))
    ]
    return sum(precision_values)/len(precision_values)

@metric
def p10(results, relevant, n=10):
    """Precision at N"""
    return len([doc for doc in results[:n] if doc['raceId'] in relevant])/n

@metric
def precision(results, relevant):
    """Precision"""
    return TP / (TP + FP)

@metric
def recall(results, relevant):
    """Recall"""
    return TP / (TP + FN)

@metric
def accuracy(results, relevant):
    """Accuracy"""
    return (TP + TN) / (TP + FP + FN + TN)

@metric
def calculate_metric(key, results, relevant):
    return metrics[key](results, relevant)

# Define metrics to be calculated
evaluation_metrics = {
    'ap': 'Average Precision',
    'p10': 'Precision at 10 (P@10)',
    'precision': 'Precision',
    'recall': 'Recall',
}

# Calculate all metrics and export results as LaTeX table
df = pd.DataFrame([['Metric','Value']] +
    [
        [evaluation_metrics[m], calculate_metric(m, results, relevant)]
        for m in evaluation_metrics
    ]
)

with open('1/results1.tex','w') as tf:
    tf.write(df.to_latex())

# -------------------------------------------------------------------------------------

# PRECISION-RECALL CURVE
# Calculate precision and recall values as we move down the ranked list
precision_values = [
    len([
        doc 
        for doc in results[:idx]
        if doc['raceId'] in relevant
    ]) / idx 
    for idx, _ in enumerate(results, start=1)
]

recall_values = [
    len([
        doc for doc in results[:idx]
        if doc['raceId'] in relevant
    ]) / len(relevant)
    for idx, _ in enumerate(results, start=1)
]

precision_recall_match = {k: v for k,v in zip(recall_values, precision_values)}

# Extend recall_values to include traditional steps for a better curve (0.1, 0.2 ...)
recall_values.extend([step for step in np.arange(0.1, 1.1, 0.1) if step not in recall_values])
recall_values = sorted(set(recall_values))

# Extend matching dict to include these new intermediate steps
for idx, step in enumerate(recall_values):
    if step not in precision_recall_match:
        if recall_values[idx-1] in precision_recall_match:
            precision_recall_match[step] = precision_recall_match[recall_values[idx-1]]
        else:
            precision_recall_match[step] = precision_recall_match[recall_values[idx+1]]

disp = PrecisionRecallDisplay([precision_recall_match.get(r) for r in recall_values], recall_values)
disp.plot()
plt.savefig('1/precision_recall1.pdf')
