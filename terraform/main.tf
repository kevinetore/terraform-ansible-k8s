resource "aws_instance" "k8s_master" {
  ami           = "ami-0a116fa7c861dd5f9" //Ubuntu AMI X86
  instance_type = "t2.medium"

  vpc_security_group_ids = [aws_security_group.k8s_master.id]

  key_name = aws_key_pair.k8s_key.key_name

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname master
              EOF

  tags = {
    Name = "K8S Master Node",
  }
}

resource "aws_instance" "k8s_worker" {
  for_each               = toset(["worker1", "worker2"])
  ami                    = "ami-0a116fa7c861dd5f9"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.k8s_worker.id]
  key_name               = aws_key_pair.k8s_key.key_name

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname ${each.key}
              EOF

  tags = {
    Name = "K8S ${each.key}"
  }
}
