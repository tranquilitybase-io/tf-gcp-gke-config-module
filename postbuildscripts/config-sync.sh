su - cloudsdk -c "gcloud config set auth/impersonate_service_account $(gcloud config get-value auth/impersonate_service_account) \
 && gcloud config set account $(gcloud config get-value account) && gcloud config set project $(gcloud config get-value project) \
 && gcloud compute ssh $4 --zone $5 --project $2 --tunnel-through-iap -- -L 3128:localhost:3128 -N -q -f"

gcloud container clusters get-credentials $1 --project $2 --zone $3

# Create ec-service-account-config.json
# SA_NAME="ec-service-account"
# gcloud iam service-accounts create ${SA_NAME} --project $2
# gcloud iam service-accounts keys create ${SA_NAME}-config.json --iam-account=${SA_NAME}@$2.iam.gserviceaccount.com
# echo "Service Account $SA_NAME created"

sleep 10
pid=$(pidof ssh)
HTTPS_PROXY=localhost:3128 gsutil cp gs://config-management-release/released/latest/config-sync-operator.yaml ./config-sync-operator.yaml
HTTPS_PROXY=localhost:3128 kubectl apply -f config-sync-operator.yaml
HTTPS_PROXY=localhost:3128 cat config-management.yaml
HTTPS_PROXY=localhost:3128 kubectl apply -f config-management.yaml
HTTPS_PROXY=localhost:3128 kubectl get all --all-namespaces
# HTTPS_PROXY=localhost:3128 kubectl create secret generic ${SA_NAME} -n cicd --from-file=${SA_NAME}-config.json
# HTTPS_PROXY=localhost:3128 kubectl create secret generic ${SA_NAME} -n ssp --from-file=${SA_NAME}-config.json

sleep 300
IFS=$'\n' read -r -d '' -a serviceaccounts < <( HTTPS_PROXY=localhost:3128 kubectl get serviceaccount --all-namespaces --selector=wi=true -o yaml | grep "  name: " | cut -f2 -d":" && printf '\0' )
IFS=$'\n' read -r -d '' -a namespaces < <( HTTPS_PROXY=localhost:3128 kubectl get serviceaccount --all-namespaces --selector=wi=true -o yaml | grep "  namespace: " | cut -f2 -d":" && printf '\0' )
for KEY in "${!namespaces[@]}"; do
   HTTPS_PROXY=localhost:3128 kubectl annotate serviceaccount --namespace "${namespaces[$KEY]:1}" "${serviceaccounts[$KEY]:1}" iam.gke.io/gcp-service-account="${serviceaccounts[$KEY]:1}"@$2.iam.gserviceaccount.com --overwrite
done


ISTIO_VERSION="$6"
if [ -z "$ISTIO_VERSION" ] 
then
	echo "Skipped Installing Istio - No Version found"
 
else
	echo "Installing Istion verison  $ISTIO_VERSION"
	DIR=`dirname $0`
	echo "Scirpt Location: $DIRECTORY"
	cd $DIR
	chmod +x ./istio.sh
        ./istio.sh $ISTIO_VERSION
fi

kill $pid
