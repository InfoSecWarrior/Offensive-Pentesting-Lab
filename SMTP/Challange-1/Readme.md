## Prerequisites

[Docker](https://docs.docker.com/engine/install/) installed on your machine
## Installation

1. Pull the Docker image:

```bash
docker pull infosecwarrior/smtp-lab:v1
```

2. Run the Docker container:

```bash
docker run -d -p 80:80 -p 25:25 -p 110:110 -p 143:143 -p 465:465 -p 993:993 -p 995:995 -p 2222:22 infosecwarrior/smtp-lab:v1
```
