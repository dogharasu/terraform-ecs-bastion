/*
############################################################################
# ECS Cluster
############################################################################
resource "aws_ecs_cluster" "ecs_cluster" {
    capacity_providers = [
        "FARGATE",
        "FARGATE_SPOT",
    ]
    name               = "dev-cluster"
    setting {
        name  = "containerInsights"
        value = "disabled"
    }
}

############################################################################
# ECS Task definition
############################################################################
resource "aws_ecs_task_definition" "task_definition" {
    container_definitions    = templatefile("./container_definitions/task_definition_container.json",{
        image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/${aws_ecr_repository.ecr.name}:latest"
    })
    cpu                      = "256"
    execution_role_arn       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ecsTaskExecutionRole"
    family                   = "dev-task"
    memory                   = "512"
    network_mode             = "awsvpc"
    requires_compatibilities = [
        "FARGATE",
    ]
    task_role_arn            = aws_iam_role.ecs_task_role.arn
    runtime_platform {
        operating_system_family = "LINUX"
    }
}

############################################################################
# ECS Service
############################################################################
resource "aws_ecs_service" "ecs_service" {
    cluster         = aws_ecs_cluster.ecs_cluster.id
    deployment_maximum_percent         = 200
    deployment_minimum_healthy_percent = 100
    desired_count                      = 0
    enable_ecs_managed_tags            = true
    enable_execute_command             = false
    health_check_grace_period_seconds  = 0
    launch_type                        = "FARGATE"
    name                               = "dev-service"
    platform_version                   = "LATEST"
    scheduling_strategy                = "REPLICA"
    task_definition                    = "${aws_ecs_task_definition.task_definition.family}:${aws_ecs_task_definition.task_definition.revision}"

    deployment_circuit_breaker {
        enable   = false
        rollback = false
    }

    deployment_controller {
        type = "ECS"
    }

    network_configuration {
        assign_public_ip = true
        security_groups  = [
            aws_security_group.sg_pub.id,
        ]
        subnets          = [
            aws_subnet.subet_pub_a.id,
        ]
    }
}
*/