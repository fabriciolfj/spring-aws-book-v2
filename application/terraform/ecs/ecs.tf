resource "aws_ecs_cluster" "spring" {
  name = "spring-service"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "spring-service" {
  name            = "spring-service"
  cluster         = aws_ecs_cluster.spring.id
  task_definition = aws_ecs_task_definition.spring-task.arn
  desired_count   = 1
  scheduling_strategy  = "REPLICA"
  force_new_deployment = true
  launch_type           = "EC2"
  #launch_type           = "FARGATE"
  #iam_role        = aws_iam_role.ecs.arn
  #depends_on      = [aws_iam_role_policy.ecs-attach]

  load_balancer {
    target_group_arn = aws_lb_target_group.test.arn
    container_name   = "teste"
    container_port   = 8080
  }
}

resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_default_security_group.ecs_security_group.id]

  subnet_mapping {
    subnet_id     = aws_subnet.subnetB.id
  }

  subnet_mapping {
    subnet_id     = aws_subnet.subnetA.id
  }

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.test.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.id
  }
}


resource "aws_ecs_task_definition" "spring-task" {
  family                    = "spring-service"
  #requires_compatibilities  = ["FARGATE"]
  #network_mode              = "awsvpc"
  cpu                       = 256
  memory                    = 512
  execution_role_arn        = aws_iam_role.ecs.arn
  task_role_arn             = aws_iam_role.ecs.arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "teste",
    "image": "docker.io/fabricio211/spring-aws:latest",
    "cpu": 256,
    "memory": 512,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 8080
      }
    ]
  }
]
TASK_DEFINITION


}