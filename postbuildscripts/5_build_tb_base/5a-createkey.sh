#!/bin/bash
MYSELF="$(realpath "$0")"
MYDIR="${MYSELF%/*}"

echo "list credentialed users:"
gcloud auth list


PROJECT_ID=$(gcloud config list --format 'value(core.project)' 2>/dev/null)
echo "Project: "$PROJECT_ID


# load SA.json into GKE
yes | gcloud iam service-accounts delete ec-service-account@$PROJECT_ID.iam.gserviceaccount.com

gcloud iam service-accounts create ec-service-account \
    --description="Eagle console service account" \
    --display-name="ec-service-account"

# get full email id of new service account
while [ 1 ]
do
  if [ -z "$fullId" ]
  then
    fullId=$(gcloud iam service-accounts list --filter="email ~ ^ec-service-account" --format='value(email)')
    sleep 10
  else
    break
  fi
done

echo $fullId
echo ""
echo "add policy"
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:$fullId \
    --role=roles/owner

#
echo ""
echo "create key"
gcloud iam service-accounts keys create $MYDIR/ec-service-account-config.json \
    --iam-account=$fullId

