#!/bin/bash
export HTTPS_PROXY="localhost:3128"
MYSELF="$(realpath "$0")"
MYDIR="${MYSELF%/*}"

kubectl apply -f $MYDIR/istio-pvt-ingressgateway.yaml
kubectl apply -f $MYDIR/istio-pvt-ingressgateway-deployment.yaml

kubectl delete svc istio-ingressgateway --namespace=istio-system