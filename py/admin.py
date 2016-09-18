from config import CONFIG
import psycopg2

CONN = psycopg2.connect(CONFIG.PSQL)


def user_admin_new(mail):
    c = CONN.cursor()
    c.execute("select id from public.user where mail=%s", (mail,))
    user_id = c.fetchone()[0]
    c.execute("INSERT INTO user_admin (id) values (%s) ON CONFLICT DO NOTHING", (user_id,))
    CONN.commit()

if __name__ == "__main__":
    user_admin_new("man@tz.world")
