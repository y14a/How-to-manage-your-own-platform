#!/bin/bash
#
# Setup Google Cloud Platform environment for the project
# Project will be created with the name given from command line,
# and service account will be setup for terraform.
# Above process were done by gcloud command, so you need to install
# then before run this script.
#

# Check prerequestition.
if [ -z "$(which gcloud)" ]; then
    echo "Cannot find gcloud command"
    exit 1
fi

# Arguments
PROJECT_NAME=$1
if [ -z "${PROJECT_NAME}" ]; then
    echo "Less argument <PROJECT NAME>"
    exit 1
fi


# Project name will be <PROJECT_NAME>-YYYYmmdd
PROJECT_ID="$(echo ${PROJECT_NAME} | tr '[:upper:]' '[:lower:]')-$(date +'%Y%m%d')"

# Service account name and its credential file path for terraform util
SA_NAME="terraform"
CREDENTIAL_FILENAME="${HOME}/gcloud-keys/${PROJECT_ID}.json"

# Generate project
gcloud projects create ${PROJECT_ID} --name ${PROJECT_NAME}

# Generate config to access the project
gcloud config configuration create ${PROJECT_NAME} --activate

# Setup configuration
gcloud config set core/project ${PROJECT_ID}

# Login to the project
gcloud auth login

# Setup terraform service account to deploy infrastructure
gcloud iam service-accounts create ${SA_NAME} --display-name ${SA_NAME}

# Get email of the created service account
SA_EMAIL=$(gcloud iam service-accounts list --filter ${SA_NAME} --format 'get(email)')

# Bind service account to the project as editor
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member serviceAccount:${SA_EMAIL} --role roles/editor


# Export credential file for terraform
mkdir -p $(dirname ${CREDENTIAL_FILENAME})
gcloud iam service-accounts key create ${CREDENTIAL_FILENAME} --iam-account ${SA_EMAIL}

#
# Finished all process. Prompt some instruction
#
echo "----- Set following before terraforming"
echo ""
echo "export GOOGLE_PROJECT=${PROJECT_ID}"
echo "export GOOGLE_CREDENTIALS=${CREDENTIAL_FILENAME}"
echo ""
echo "----- Also set following before terraforming"
echo "Example"
echo "  export GOOGLE_REGION='asia-northeast1'"
echo "  export GOOGLE_ZONE='asia-northeast1-c'"
echo ""
