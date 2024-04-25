## Installation

- Pull the Docker image:

```bash
docker pull infosecwarrior/web:v16
```
- Run the Docker container:

```bash
docker run -d -p 80:80 -p 8080:8080 -p 8111:8111 -p 2222:22 infosecwarrior/web:v16
```

**Please Note:** This image requires a minimum of 4GB RAM to run successfully. Additionally, all service startup processes may take approximately 10 minutes. Your patience is appreciated during this time.
