#!/bin/bash
export HTTPS_PROXY="localhost:3128"
MYSELF="$(realpath "$0")"
MYDIR="${MYSELF%/*}"

# creates namespaces cicd / ssp
kubectl apply -f $MYDIR/namespaces.yaml

# create config map
kubectl apply -f $MYDIR/configmap.yaml

kubectl create secret generic ec-service-account -n cicd --from-file=$MYDIR/ec-service-account-config.json
kubectl create secret generic ec-service-account -n ssp --from-file=$MYDIR/ec-service-account-config.json

# set basic auth
#kubectl create secret generic dac-user-pass -n cicd --from-literal=username=dac --from-literal=password='bad_password' --type=kubernetes.io/basic-auth
#kubectl create secret generic dac-user-pass -n ssp --from-literal=username=dac --from-literal=password='bad_password' --type=kubernetes.io/basic-auth

# point to folder
kubectl create secret generic gcr-folder -n cicd --from-literal=folder=940339059902

# deploy apps
kubectl apply -f $MYDIR/storageclasses.yaml
#kubectl apply -f $MYDIR/jenkins-master.yaml
# kubectl --namespace istio-system get service istio-private-ingressgateway
