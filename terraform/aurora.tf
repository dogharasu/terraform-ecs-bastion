############################################################################
# Aurora
############################################################################
resource "aws_rds_cluster" "aurora_cluster" {
    backtrack_window                    = 0
    backup_retention_period             = 1
    cluster_identifier                  = "dev-aurora"
    copy_tags_to_snapshot               = true
    database_name                       = "dev_table"
    db_cluster_parameter_group_name     = "default.aurora-mysql5.7"
    db_subnet_group_name                = aws_db_subnet_group.subnet_group.name
    deletion_protection                 = false
    enable_http_endpoint                = false
    enabled_cloudwatch_logs_exports     = []
    engine                              = "aurora-mysql"
    engine_mode                         = "provisioned"
    engine_version                      = "5.7.mysql_aurora.2.07.2"
    iam_database_authentication_enabled = false
    iam_roles                           = []
    master_username                     = "admin"
    master_password                     = "password"
    port                                = 3306
    preferred_backup_window             = "13:25-13:55"
    preferred_maintenance_window        = "fri:19:00-fri:19:30"
    skip_final_snapshot                 = true
    storage_encrypted                   = true
    vpc_security_group_ids              = [
        aws_security_group.sg_pri.id,
    ]
}

resource "aws_rds_cluster_instance" "aurora_instance" {
    cluster_identifier                    = aws_rds_cluster.aurora_cluster.cluster_identifier  
    auto_minor_version_upgrade            = false
    availability_zone                     = "ap-northeast-1a"
    engine                                = "aurora-mysql"
    instance_class                        = "db.t3.small"
    performance_insights_enabled          = false
    preferred_maintenance_window          = "thu:17:23-thu:17:53"
    promotion_tier                        = 1
    publicly_accessible                   = false
    tags_all                              = {}
}
