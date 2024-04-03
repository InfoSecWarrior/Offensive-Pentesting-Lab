## Installation

- Pull the Docker image:

```bash
docker pull infosecwarrior/smb-lab:v1
```
- Run the Docker container:

```bash
docker run -d  -p 445:455 -p 139:139 -p 22:22 infosecwarrior/smb-lab:v1
```
