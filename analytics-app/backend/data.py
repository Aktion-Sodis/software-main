import json
import pandas as pd

DATA_FILE = "data.json"

def import_data(DATA_FILE):
    f = open(DATA_FILE)
    data = json.load(f)
    f.close()

    return data

data = import_data(DATA_FILE)

print(data["images"])

