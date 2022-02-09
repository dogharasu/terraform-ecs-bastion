#/bin/sh
set -e
SSM_ACTIVATION=$(aws ssm create-activation \
--default-instance-name "bastion-container" \
--iam-role "dev-ssm-role" \
--registration-limit 1 \
--region "ap-northeast-1")
export SSM_ACTIVATION_CODE=$(echo $SSM_ACTIVATION | jq -r .ActivationCode)
export SSM_ACTIVATION_ID=$(echo $SSM_ACTIVATION | jq -r .ActivationId)
amazon-ssm-agent -register -code $SSM_ACTIVATION_CODE -id $SSM_ACTIVATION_ID -region ap-northeast-1
exec "$@"
