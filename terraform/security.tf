//security.tf
data "aws_vpc" "default" {
  default = true
}

resource "aws_key_pair" "k8s_key" {
  key_name   = "k8s-key"
  public_key = file("~/.ssh/k8s-key.pub")
}

# https://kubernetes.io/docs/reference/networking/ports-and-protocols/
resource "aws_security_group" "k8s_master" {
  name   = "k8s_master_sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # Kubernetes API server
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
  }

  # etcd server client API	
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
  }

  # Kubelet API
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
  }

  # kube-scheduler	
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 10259
    to_port     = 10259
    protocol    = "tcp"
  }

  # kube-controller-manager
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 10257
    to_port     = 10257
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "k8s_worker" {
  name   = "k8s_worker_sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 10256
    to_port     = 10256
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 30000
    to_port     = 32767
    protocol    = "udp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
