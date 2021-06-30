git clone https://github.com/terraform-google-modules/terraform-example-foundation.git
cp ./org.auto.tfvars ./terraform-example-foundation/1-org/envs/shared
for i in `find -name 'backend.tf'`; do sed -i 's/UPDATE_ME/'$TG_BUCKET'/' $i; done
cd ./terraform-example-foundation/1-org
cp ../build/tf-wrapper.sh .
chmod 755 ./tf-wrapper.sh
cd ./envs/shared/
rm terraform.example.tfvars
rm providers.tf
ls -la
terraform --version
terraform init
terraform plan
terraform destroy -auto-approve
terraform apply -auto-approve
