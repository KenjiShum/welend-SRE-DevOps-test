The nginx url: http://13.213.46.219/

Security hardening: 
- IP Whitelisting: Only trusted sources are allowed to access the instance, effectively reducing the risk of unauthorized access.
- SSH Encryption Key: Implemented the use of SSH keys for secure, encrypted connections.
- Port Control: To minimize potential points of entry, only necessary ports have been opened on the instance.

Health check:
To ensure the continuous, healthy operation of our services, a small health check monitor runs as a sidecar container. This monitor can be scaled as required and is capable of sending alerts if any issues are detected.

Resource log:
Making use of the docker stats command to monitor resource usage. This can be run in the background as a system daemon, providing continuous, real-time data on our Docker containers.