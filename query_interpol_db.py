import duckdb

sql_stmts = [
  "DESCRIBE",
  """
  select *
    from mart.fct_sighting
   limit 10
  """,
  """
  select *
    from mart.dim_witness
   limit 10
  """,
  """
  select *
    from mart.dim_agent
   limit 10
  """
]

con = duckdb.connect("interpol_db.duckdb", read_only=False)

[ print(con.execute(sql).fetchdf()) for sql in sql_stmts ]