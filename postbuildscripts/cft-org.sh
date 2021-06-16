git clone https://github.com/terraform-google-modules/terraform-example-foundation.git
cp ./org.tfvars ./terraform-example-foundation/1-org/envs/shared
rm terraform.example.tfvars
rm backend.tf
cd ./terraform-example-foundation/1-org
cp ../build/tf-wrapper.sh .
chmod 755 ./tf-wrapper.sh
cd ./envs/shared/
ls -la
terraform --version
terraform init
terraform plan
