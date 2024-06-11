# %% 
import sqlalchemy
import pandas as pd
import os


def import_query(path):
    with open("src_gu/feature_store/"+path, 'r') as open_file:
        return open_file.read()

# %%

cwd = os.getcwd()  # Get the current working directory (cwd)
files = os.listdir(cwd)  # Get all the files in that directory
origin_engine = sqlalchemy.create_engine("sqlite:///"+cwd+"\\"+files[1]+"../../data/database.db")
target_engine = sqlalchemy.create_engine("sqlite:///../ds_points_gu/data/feature_store.db")
# %%
 
query = import_query("fs_horarios.sql") #import da query
query_fmt = query.format(date='2024-06-06') #substituindo por uma data
print(query_fmt)
# %%
df = pd.read_sql(query_fmt, origin_engine)
df.head(5)