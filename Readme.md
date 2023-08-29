Initially, I aimed to deploy the Nginx container using Amazon Elastic Kubernetes Service (EKS), considering the power and flexibility that Kubernetes provides. However, I ran into some challenges with setting up a public IngressClass. These complications arose due to differences in handling public/private subnets and IAM as it difference from Aliyun. After wrestling with these issues, I decided to turn back and adopted a simpler approach using EC2 instances.

To give a comprehensive view of my efforts, I've included both the EKS and EC2 approaches in this repository. Each approach is housed in its own dedicated directory and is accompanied by a README file that provides a more detailed explanation of my process.

Despite the detour, I remain enthusiastic about Kubernetes and its potential. I am keen on expanding my knowledge in this area and utilizing it in future projects.

Thank you for taking the time to consider my application. I hope this project showcases not only my technical skills but also my ability to adapt and pivot when initial plans don't pan out. I eagerly await your feedback!# welend-SRE-DevOps-test
