import os
import requests
from flask import Flask, request, jsonify

app = Flask(__name__)

GITHUB_TOKEN = os.environ["GITHUB_TOKEN"]
GITHUB_OWNER = os.environ["GITHUB_OWNER"]
GITHUB_REPO = os.environ["GITHUB_REPO"]

@app.route("/webhook", methods=["POST"])
def webhook():
    payload = request.get_json(force=True)
    alerts = payload.get("alerts", [])

    for alert in alerts:
        if alert.get("status") != "firing":
            continue

        labels = alert.get("labels", {})
        dispatch_body = {
            "event_type": "rollback-trigger",
            "client_payload": {
                "pod": labels.get("pod", "unknown"),
                "namespace": labels.get("namespace", "unknown"),
                "alertname": labels.get("alertname", ""),
            },
        }

        resp = requests.post(
            f"https://api.github.com/repos/{GITHUB_OWNER}/{GITHUB_REPO}/dispatches",
            headers={
                "Authorization": f"token {GITHUB_TOKEN}",
                "Accept": "application/vnd.github+json",
            },
            json=dispatch_body,
            timeout=10,
        )
        resp.raise_for_status()

    return jsonify({"status": "ok"}), 200

@app.route("/healthz", methods=["GET"])
def healthz():
    return jsonify({"status": "healthy"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)