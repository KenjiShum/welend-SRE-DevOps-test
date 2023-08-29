Health check
(not implemented):
The initial plan was to implement a Golang program that exports health metrics to Prometheus and set alert rules on Grafana.
(implemented):
The implemented health check makes use of Kubernetes Probes as defined in the deployment YAML.

Security:
1. Central Gateway: All traffic is directed through a central gateway located at the edge of the VPC. This allows us to have better control and visibility over network traffic.
2. Access Control and Firewall: We can applied Access Control Lists (ACLs) and firewalls between the cluster and resources within the VPC to further secure our setup from hacker.

Visualize monitoring(not implemented):
The original plan was to deploy Grafana and Prometheus (if they did not already exist) using Helm for visualization and monitoring.