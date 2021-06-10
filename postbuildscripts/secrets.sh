cd ..
HTTPS_PROXY=localhost:3128 kubectl apply -f ./yaml
HTTPS_PROXY=localhost:3128 kubectl get all --all-namespaces