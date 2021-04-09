gcloud container clusters get-credentials $1 --project $2 --zone $3
gcloud compute ssh $4 --project $2 --zone $5 --tunnel-through-iap -- -L 3128:localhost:3128 -N -q -f
sleep 10
pid=$(pidof ssh)
HTTPS_PROXY=localhost:3128 gsutil cp gs://config-management-release/released/latest/config-sync-operator.yaml ./config-sync-operator.yaml
HTTPS_PROXY=localhost:3128 kubectl apply -f config-sync-operator.yaml
HTTPS_PROXY=localhost:3128 cat config-management.yaml
HTTPS_PROXY=localhost:3128 kubectl apply -f config-management.yaml
HTTPS_PROXY=localhost:3128 kubectl get all --all-namespaces
kill $pid

