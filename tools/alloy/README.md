# Grafana Alloy

Grafana Alloy is Grafana's telemetry collector for gathering and forwarding
metrics, logs, and traces. This directory installs the upstream Alloy Helm
chart through Argo CD in the `alloy` namespace. A single Alloy Deployment
discovers pods across the cluster and scrapes only pods opted in with these
annotations:

```yaml
prometheus.io/scrape: "true"
prometheus.io/port: "9464"
# Optional; defaults to /metrics.
prometheus.io/path: "/metrics"
```

The endpoint must expose the OpenTelemetry SDK metrics in Prometheus
exposition format (commonly provided by an OTel Prometheus exporter). Alloy
forwards scraped samples to Mimir at `mimir-gateway.mimir.svc.cluster.local`
under the `anonymous` tenant.
