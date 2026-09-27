# Grafana Alloy

Grafana Alloy is Grafana's telemetry collector for gathering and forwarding
metrics, logs, and traces. This directory installs the upstream Alloy Helm
chart through Argo CD in the `alloy` namespace. The chart uses its default
configuration; no collection pipelines or destinations are configured here.
