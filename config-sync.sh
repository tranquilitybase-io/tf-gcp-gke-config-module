gcloud container clusters get-credentials $1 --project $2 --zone $3
gcloud compute ssh $4 --project $2 --zone $5 --tunnel-through-iap -- -L 3128:localhost:3128 -N -q -f
sleep 10
pid=$(pidof ssh)
HTTPS_PROXY=localhost:3128 gsutil cp gs://config-management-release/released/latest/config-sync-operator.yaml ./config-sync-operator.yaml
HTTPS_PROXY=localhost:3128 kubectl apply -f config-sync-operator.yaml
HTTPS_PROXY=localhost:3128 cat config-management.yaml
HTTPS_PROXY=localhost:3128 kubectl apply -f config-management.yaml
HTTPS_PROXY=localhost:3128 kubectl get all --all-namespaces
sleep 300
IFS=$'\n' read -r -d '' -a serviceaccounts < <( HTTPS_PROXY=localhost:3128 kubectl get serviceaccount --all-namespaces --selector=wi=true -o yaml | grep "  name: " | cut -f2 -d":" && printf '\0' )
IFS=$'\n' read -r -d '' -a namespaces < <( HTTPS_PROXY=localhost:3128 kubectl get serviceaccount --all-namespaces --selector=wi=true -o yaml | grep "  namespace: " | cut -f2 -d":" && printf '\0' )
for KEY in "${!namespaces[@]}"; do
   HTTPS_PROXY=localhost:3128 kubectl annotate serviceaccount --namespace "${namespaces[$KEY]:1}" "${serviceaccounts[$KEY]:1}" iam.gke.io/gcp-service-account="${serviceaccounts[$KEY]:1}"@$2.iam.gserviceaccount.com --overwrite
done
kill $pid

#Start of Istio Installation
ISTIO_VERSION=1.9.4

sp='/-\|'
sc=0
spin() {
    printf "\b${sp:sc++:1}"
    ((sc==${#sp})) && sc=0
    sleep 0.1
}


endspin() {
    printf '\r%s\n' "$*"
    sleep 0.1
}


# Check that kubectl is installed

printf "Checking kubectl is installed...\n"

if ! [ -x "$(command -v kubectl)" ]; then
  case "$OSTYPE" in
  darwin*)  curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl; chmod +x kubectl ; mv kubectl /usr/local/bin/;;
  linux*)   curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl; chmod +x kubectl ; mv kubectl /usr/local/bin/ ;;
  *)        echo "Unknown OS: $OSTYPE" ;;
esac


fi


printf "Checking curl is installed...\n"

if ! [ -x "$(command -v curl)" ]; then
  case "$OSTYPE" in
  darwin*)  brew install curl ;;
  linux*)   sudo apt install curl ;;
  *)        echo "Unknown OS: $OSTYPE" ;;
esac


fi

printf "Downloading and installing Istio...\n"
# Download Istio binaries
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=${ISTIO_VERSION} TARGET_ARCH=x86_64 sh - > /dev/null 2>&1
version=$(ls -1d istio-1*)
export PATH="$PATH:$PWD/$version/bin"

export HTTPS_PROXY="localhost:3128"

#Initalise istio
istioctl operator init > /dev/null 2>&1

sleep 30

#End of istio installation
