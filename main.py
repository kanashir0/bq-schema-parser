from sqlalchemy import create_engine, MetaData
from sqlalchemy.inspection import inspect

import os
import json

# Criação do diretório `data/schema_parser/bq_schemas` caso ele não exista
directory = "./data/schema_parser/bq_schemas"
if not os.path.exists(directory):
    os.makedirs(directory)

# Criação das engines
mysql_engine = create_engine("mysql+mysqlconnector://root:dbpass@localhost:3306/classicmodels", echo=True)
bq_engine = create_engine("bigquery://project_id/schema_parser", echo=True)

# Reflect das tabelas para coletar os metadados
metadata_obj = MetaData()
metadata_obj.reflect(mysql_engine)

# Para cada tabela, criação do arquivo JSON contendo o schema do BQ
for table_name in metadata_obj.tables:
    table = inspect(metadata_obj.tables[table_name])

    table_schema = []
    for column in table.columns:
        table_schema.append({
            "name": column.name,
            "type": column.type.compile(dialect=bq_engine.dialect),
            "mode": "NULLABLE" if column.nullable else "REQUIRED",
        })

    print(f"Creating {table_name}.json")
    with open(f"{directory}/{table_name}.json", "w") as f:
        json.dump(table_schema, f, indent=4)
