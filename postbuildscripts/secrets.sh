echo test
cd ..
HTTPS_PROXY=localhost:3128 kubectl apply -f ./yaml
cat secret-0.yaml
HTTPS_PROXY=localhost:3128 kubectl get all --all-namespaces