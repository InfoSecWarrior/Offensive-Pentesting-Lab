## Installation

- Pull the Docker image:

```bash
docker pull infosecwarrior/web-lab:v1
```
- Run the Docker container:

```bash
docker run -dt -p 2222:22 -p 80:80 -p 3306:3306 -p 21:21 -p 8080:10000 -p 139:139 -p 445:445 infosecwarrior/web-lab:v1
```
