#!/bin/bash
export HTTPS_PROXY="localhost:3128"
MYSELF="$(realpath "$0")"
MYDIR="${MYSELF%/*}"

kubectl apply -f $MYDIR/kiali.yaml -f $MYDIR/grafana.yaml
kubectl apply -f $MYDIR/istio-kiali.yaml  -f $MYDIR/istio-grafana.yaml