#!/bin/bash
# Local simulation of the Jenkins pipeline stages (same commands, WORKSPACE = this dir).
# Usage: bash simulate_pipeline.sh   (Linux/macOS/WSL/Git Bash)
set -e
cd "$(dirname "$0")"
WORKSPACE="$(pwd)"
PY=python3; $PY -c "import sys" >/dev/null 2>&1 || PY=python
VENV="$WORKSPACE/venv"; DEPLOY_DIR="$WORKSPACE/python-app-deploy"
if [ -d "$VENV/Scripts" ]; then BIN="$VENV/Scripts"; else BIN="$VENV/bin"; fi

echo "=== Stage: Build ==="
[ -d "$VENV" ] || $PY -m venv "$VENV"
if [ -d "$VENV/Scripts" ]; then BIN="$VENV/Scripts"; else BIN="$VENV/bin"; fi
"$BIN/python" -m pip install -q -r requirements.txt

echo "=== Stage: Test ==="
"$BIN/python" -m unittest discover -s . -p "test_*.py" -v

echo "=== Stage: Deploy ==="
mkdir -p "$DEPLOY_DIR"; cp "$WORKSPACE/app.py" "$DEPLOY_DIR/"

echo "=== Stage: Run Application ==="
nohup "$BIN/python" "$DEPLOY_DIR/app.py" > "$DEPLOY_DIR/app.log" 2>&1 &
APP_PID=$!; echo $APP_PID > "$DEPLOY_DIR/app.pid"; sleep 3

echo "=== Stage: Test Application ==="
"$BIN/python" "$WORKSPACE/test_app.py"
"$BIN/python" -c "import urllib.request;b=urllib.request.urlopen('http://127.0.0.1:5000/').read().decode();print('Live response:',b);assert b=='Hello, Jenkins Multi-Stage Pipeline!'"

kill $APP_PID 2>/dev/null || true
echo "Pipeline completed successfully!"
