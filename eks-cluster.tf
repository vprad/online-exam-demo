module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 19.0"
    cluster_name = "myapp-eks-cluster"
    cluster_version = "1.27"

    cluster_endpoint_public_access  = true

    vpc_id = "vpc-04bb19fbdabd9f5ce"
    subnet_ids = ["subnet-0da06c4b288d1d081", "subnet-042e7e5087d2d3cc7", "subnet-05c8300e1f287db75", "subnet-0894e21266fc15379", "subnet-08a44389ebd45aa56"]

    tags = {
        environment = "development"
        application = "myapp"
    }

    eks_managed_node_groups = {
        dev = {
            min_size = 1
            max_size = 3
            desired_size = 2

            instance_types = ["t2.medium"]
        }
    }
}
