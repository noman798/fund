from config import CONFIG
import psycopg2

conn = psycopg2.connect(CONFIG.PSQL)

c = conn.cursor()
c.execute("show search_path")
r = c.fetchone()
print(r)
c.execute("SET search_path=public")
c.execute("show search_path")
r = c.fetchone()
print(r)
c.execute("select id from user where mail=%s", ("man@tz.world",))
r = c.fetchone()[0]
print(r)
#c.execute("INSERT INTO test (num, data) VALUES (%s, %s)")
