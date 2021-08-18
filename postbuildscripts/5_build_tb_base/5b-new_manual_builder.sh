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
#kubectl create secret generic gcr-folder -n cicd --from-literal=folder=940339059902

# deploy apps
kubectl apply -f $MYDIR/storageclasses.yaml
#kubectl apply -f $MYDIR/jenkins-master.yaml
# kubectl --namespace istio-system get service istio-private-ingressgateway


# ==== Create K8s SA for jenkins ====
echo "---- Create K8s SA for jenkins ----"
tokenId=$(kubectl describe serviceaccount cicd-service-account -n=cicd | grep Token | awk '{print $2}')
echo "tokenId: $tokenId"
token=$(kubectl describe secret $tokenId --namespace=cicd | grep token | awk 'FNR == 3 {print $2}')
echo "token: $token"
kubectl create secret generic cicd-service-account-token -n cicd --from-literal=token=$token

kubectl create clusterrolebinding cicd-role-binding --clusterrole=admin --serviceaccount cicd:cicd-service-account
