import pandas as pd
from sqlite3 import connect
from os import path, listdir
def to_db(link,filename, type_fixes, fixes):
    db = pd.read_excel(path.join(link, filename))
    db = db.dropna(how='all', axis='columns') #zbrise prazne stolpce
    db = db.fillna(value=-1) #zamenja prazne celice z -1
    for x in db:
        if(x in fixes):
            db[x] = db[x].apply(fixes[x])
        elif(x in type_fixes):
            db[x] = db[x].astype(type_fixes[x])

    cnx = connect(path.join(link, path.splitext(filename)[0] + ".db"))
    db.to_sql(name=path.splitext(filename)[0], con=cnx)

if __name__ == "__main__":
    def la(x): #potrebno ce so prazne celice
        try:
            return tuple(float(y) for y in x.split(","))
        except:
            return x
    type_fixes = {"ID_DREVESA": int, "Obseg": float}
    fixes = {"Koordinate": la}

    PATH = "excel/"
    for file in listdir(PATH):
        if file.endswith(".xlsx"):
            print(f"Pretvarjam datoteko {PATH}{file}, kot {path.join(PATH, path.splitext(file)[0])}.db")
            to_db(PATH,file, type_fixes, fixes)