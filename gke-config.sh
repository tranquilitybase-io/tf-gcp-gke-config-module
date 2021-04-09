gcloud container clusters get-credentials $1 --project $2 --zone $3
sleep 10
gcloud compute ssh $4 --project $2 --zone $5 --tunnel-through-iap -- -L 3128:localhost:3128 -N -q -f
echo "###1"
pid=$(pidof ssh)
echo "###2"
sleep 30
HTTPS_PROXY=localhost:3128 gsutil cp gs://config-management-release/released/latest/config-sync-operator.yaml ./config-sync-operator.yaml
HTTPS_PROXY=localhost:3128 kubectl apply -f config-sync-operator.yaml
sleep 10
HTTPS_PROXY=localhost:3128 cat config-management.yaml
HTTPS_PROXY=localhost:3128 kubectl apply -f config-management.yaml
sleep 10
HTTPS_PROXY=localhost:3128 kubectl get all --all-namespaces
sleep 10
kill pid

