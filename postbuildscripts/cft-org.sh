git clone https://github.com/terraform-google-modules/terraform-example-foundation.git
ls -la
echo dir1
cp ./org.tfvars ./terraform-example-foundation/1-org/envs/shared
cd ./terraform-example-foundation/1-org
cp ../build/tf-wrapper.sh .
chmod 755 ./tf-wrapper.sh
cd ./envs/shared/
pwd
ls -la
echo dir2
terraform --version
