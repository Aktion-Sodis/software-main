import json
import pandas as pd

FILE = "data/humission/AppliedIntervention/ddkdud35fe52vlz7pfjhvk5ccq.json"

def import_data(FILE):
    f = open(FILE)
    data = json.load(f)
    f.close()

    return data

data = import_data(FILE)

print(data)
