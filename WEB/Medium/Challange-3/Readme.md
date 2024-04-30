## Installation

- Pull the Docker image:

```bash
docker pull infosecwarrior/web:v14
```
- Run the Docker container:

```bash
docker run -d -p 80:80 -p 2222:22 -p 1883:1883 -p 5672:5672 -p 8161:8161 -p 61613:61613 -p 61614:61614 -p 61616:61616 infosecwarrior/web:v14 
```
