su - cloudsdk -c "gcloud config set auth/impersonate_service_account $(gcloud config get-value auth/impersonate_service_account) \
 && gcloud config set account $(gcloud config get-value account) && gcloud config set project $(gcloud config get-value project) \
 && gcloud compute ssh $4 --zone $5 --project $2 --tunnel-through-iap -- -L 3128:localhost:3128 -N -q -f"
 
gcloud container clusters get-credentials $1 --project $2 --zone $3
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


# Establish
DIR=`dirname $0`
echo "Scirpt Location: $DIRECTORY"



# =====================
# ===== 1 istio =======
# =====================

ISTIO_VERSION="$6"
if [ -z "$ISTIO_VERSION" ] 
then
	echo "1 Skipped Installing Istio - No Version found"
 
else
	echo "1 Installing Istio version  $ISTIO_VERSION"
	cd $DIR
	chmod +x ./1_istio/istio.sh
        ./1_istio/istio.sh $ISTIO_VERSION
  cd ..
fi





# =======================================
# ===== 2 part of mngmnt plane tf =======
# =======================================


# =======================================
# ========== 3 pvt ingress ==============
# =======================================
echo "3 pvt ingress"
cd $DIR
chmod +x ./3_private_ingress/ingress.sh
      ./3_private_ingress/ingress.sh
cd ..

# =======================================
# ========= 4 istio services ============
# =======================================
echo "4 istio services "
cd $DIR
chmod +x ./4_istio_services/istio_services.sh
      ./4_istio_services/istio_services.sh
cd ..


# =======================================
# =========== 5 build tb base ===========
# =======================================
#echo "5 build tb base"
#cd $DIR
#chmod +x ./5_build_tb_base/5a-createkey.sh
#      ./5_build_tb_base/5a-createkey.sh
#
#chmod +x ./5_build_tb_base/5b-new_manual_builder.sh
#      ./5_build_tb_base/5b-new_manual_builder.sh
#cd ..


# =======================================
# ======== 6 in mngmt plane tf ==========
# =======================================


# =======================================
# ========== 7 ccerts ===================
# =======================================
#echo "7 ccerts"
#cd $DIR
#chmod +x ./7_ccerts/certs.sh
#      ./7_ccerts/certs.sh
#cd ..


# =======================================
# ========== 8 EC =======================
# =======================================
echo "8 EC "
cd $DIR
chmod +x ./8_EC/ec.sh
      ./8_EC/ec.sh
cd ..



kill $pid