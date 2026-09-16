import os

from flask import Flask, jsonify

app = Flask(__name__)

# Peer containers are reached through Docker's embedded DNS by container name
MYSQL_HOST = os.environ.get("MYSQL_HOST", "mysql")
MYSQL_PASSWORD = os.environ.get("MYSQL_PASSWORD", "rootpass")
REDIS_HOST = os.environ.get("REDIS_HOST", "redis")


@app.route('/about', methods=['GET'])
def about():
    return jsonify({
        "name": "Simple REST API",
        "version": "1.0",
        "description": "This is a simple REST API built with Flask."
    })


@app.route('/redis', methods=['GET'])
def redis_check():
    """Increment a hit counter in the redis container over my-bridge-net."""
    try:
        import redis
        r = redis.Redis(host=REDIS_HOST, port=6379, socket_connect_timeout=3)
        hits = r.incr("hits")
        return jsonify({"redis_host": REDIS_HOST, "status": "connected", "hits": hits})
    except Exception as exc:  # report, don't crash
        return jsonify({"redis_host": REDIS_HOST, "status": "error", "error": str(exc)}), 503


@app.route('/mysql', methods=['GET'])
def mysql_check():
    """Run SELECT VERSION() against the mysql container over my-bridge-net."""
    try:
        import pymysql
        conn = pymysql.connect(host=MYSQL_HOST, user="root", password=MYSQL_PASSWORD,
                               connect_timeout=3)
        with conn.cursor() as cur:
            cur.execute("SELECT VERSION()")
            version = cur.fetchone()[0]
        conn.close()
        return jsonify({"mysql_host": MYSQL_HOST, "status": "connected", "version": version})
    except Exception as exc:
        return jsonify({"mysql_host": MYSQL_HOST, "status": "error", "error": str(exc)}), 503


if __name__ == '__main__':
    # host 0.0.0.0 is required so the published port (-p 5001:5001) is reachable
    app.run(host='0.0.0.0', debug=True, port=5001)  # Specify the port number here
