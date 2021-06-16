git clone https://github.com/terraform-google-modules/terraform-example-foundation.git
cp ./org.tfvars ./terraform-example-foundation/1-org/envs/shared
rm terraform.example.tfvars
for i in `find -name 'backend.tf'`; do sed -i 's/UPDATE_ME/$TG_BUCKET/' $i; done
cd ./terraform-example-foundation/1-org
cp ../build/tf-wrapper.sh .
chmod 755 ./tf-wrapper.sh
cd ./envs/shared/
ls -la
echo $1
terraform --version
terraform init
terraform plan
