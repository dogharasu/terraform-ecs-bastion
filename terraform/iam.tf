############################################################################
# IAM Policy
############################################################################
resource "aws_iam_policy" "ecs_task_policy" {
        description = "dev-ecs-policy"
    name        = "dev-ecs-policy"
    path        = "/"
    policy      = file("./iam_policy/ecs-task.json")
}

resource "aws_iam_policy" "ssm_policy" {
    description = "dev-ssm-policy"
    name        = "dev-ssm-policy"
    path        = "/"
    policy      = file("./iam_policy/ssm.json")
}

############################################################################
# IAM Role
############################################################################
resource "aws_iam_role" "ecs_task_role" {
    assume_role_policy    = file("./iam_policy/ecs-task-trust.json")
    description           = "Allows ECS tasks to call AWS services on your behalf."
    managed_policy_arns   = [aws_iam_policy.ecs_task_policy.arn]
    max_session_duration  = 3600
    name                  = "dev-ecs-role"
    path                  = "/"
}

resource "aws_iam_role" "ssm_role" {
    assume_role_policy    = file("./iam_policy/ssm-trust.json")
    description           = "Allows SSM to call AWS services on your behalf"
    managed_policy_arns   = [aws_iam_policy.ssm_policy.arn]
    max_session_duration  = 3600
    name                  = "dev-ssm-role"
    path                  = "/"
}

