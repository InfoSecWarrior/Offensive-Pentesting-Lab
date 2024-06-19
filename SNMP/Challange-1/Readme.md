## Installation

- Pull the Docker image:

```bash
docker pull infosecwarrior/snmp-lab:v1
```
- Run the Docker container:

```bash
docker run -d -p 2222:22 -p 8080:8080 -p 80:80 -p 21:21 -p 161:161/udp infosecwarrior/snmp-lab:v1
```
