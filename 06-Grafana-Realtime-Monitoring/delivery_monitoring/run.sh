#!/bin/bash
# Exercise 6 - run the full monitoring stack on Linux/WSL (from delivery_monitoring/)
set -e
pip3 install -r requirements.txt
nohup python3 delivery_metrics.py > delivery_metrics.log 2>&1 &
echo $! > delivery_metrics.pid
sleep 2
curl -s http://localhost:8000/metrics | grep -E '^(total|pending|on_the_way|average)_'

docker rm -f prometheus grafana 2>/dev/null || true
docker run -d --name prometheus --network=host \
  -v "$PWD/prometheus.yml:/etc/prometheus/prometheus.yml" \
  -v "$PWD/alert_rules.yml:/etc/prometheus/alert_rules.yml" prom/prometheus

# Grafana with datasource + dashboard pre-provisioned (manual UI steps also work)
docker run -d --name grafana -p 3000:3000 \
  -v "$PWD/grafana/provisioning:/etc/grafana/provisioning" \
  -v "$PWD/grafana/dashboards:/var/lib/grafana/dashboards" grafana/grafana

sleep 20
echo "== Prometheus targets =="; curl -s http://localhost:9090/api/v1/targets | grep -o '"health":"[a-z]*"'
echo "== Prometheus alerts ==";  curl -s http://localhost:9090/api/v1/alerts
echo "Prometheus: http://localhost:9090   Grafana: http://localhost:3000 (admin/admin)"
