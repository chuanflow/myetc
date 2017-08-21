import pymysql
import json
class MySqlDb(object):
    def __init__(self, host=None, port=None, user=None, pwd=None, db=None):
        self.mysql_host = host if host is not None else '127.0.0.1'
        self.mysql_port = port if port is not None else 3306
        self.mysql_user = user if user is not None else 'root'
        self.mysql_pwd = pwd if pwd is not None else 'Aa1111'
        self.mysql_db = db if host is not None else 'yunshutmp1'
        self.mysql_conn = self.__get_conn()
    def __del__(self):
        self.mysql_conn.close()
    def execute_sql(self, sql, args=None):
        ret = 0
        try:
            with self.mysql_conn.cursor() as cursor:
                if isinstance(args, list):
                    ret = cursor.executemany(sql, args)
                else:
                    ret = cursor.execute(sql, args)
            self.mysql_conn.commit()
        except pymysql as e:
            print("[ERR][MySqlDb]", e.args)
        return ret
    def query_sql(self, sql, args=None):
        ret = []
        try:
            with self.mysql_conn.cursor() as cursor:
                cursor.execute(sql, args)
                rs = cursor.fetchall()
                for row in rs:
                    ret.append(row)
        except pymysql.Error as e:
            print("[ERR][MySqlDb]", e.args)
        return ret
    def __get_conn(self):
        return pymysql.connect(host=self.mysql_host,
                               user=self.mysql_user,
                               password=self.mysql_pwd,
                               db=self.mysql_db,
                               port=self.mysql_port,
                               charset='utf8',
                               cursorclass=pymysql.cursors.DictCursor)
if __name__ == "__main__":
    mysqldb = MySqlDb()
    ret = mysqldb.query_sql("select title,content from article_article")
    for index,i in enumerate(ret):
        retqq = ret[index]["content"]
        retqq = json.loads(retqq)
        with open("%s.md"%ret[index]["title"],"w+") as f:
            f.write(retqq["markdown"])

