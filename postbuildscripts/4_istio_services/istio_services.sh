#!/bin/bash
export HTTPS_PROXY="localhost:3128"


kubectl apply -f kiali.yaml -f grafana.yaml
kubectl apply -f istio-kiali.yaml  -f istio-grafana.yaml