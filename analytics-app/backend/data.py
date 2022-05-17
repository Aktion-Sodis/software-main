import json


def import_data(FILE):
    f = open(FILE)
    data = json.load(f)
    f.close()

    return data
