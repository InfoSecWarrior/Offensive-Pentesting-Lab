<h1 align="center">Offensive Pentesting Lab</h1>

**Offensive-Pentesting-Lab** is a collection of vulnerable Docker containers and ready-made VM images designed for safe practice of penetration testing, vulnerability analysis, and learning exploitation techniques. It is suitable for both beginner security researchers and experienced professionals who want to quickly deploy a "sandbox" with a number of services for training purposes.

> - All containers are intentionally vulnerable.  
> - **Never** run them in a production network or on a host with direct Internet access without proper filtering. 
> - It’s best to use an isolated VM or virtual VLAN, and restrict incoming traffic using a firewall.


## 📑 Table of Contents

- [Requirements](#requirements)
- [Repository Structure](#repository-structure)
- [Quick Start](#quick-start)
- [Running Multiple Containers with docker-compose](#docker-compose-example)
- [Lab Exercise Workflow](#lab-exercise-workfrow)
- [Contributing](#contributing)


## Requirements

| Software       | Minimum Version |
|----------------|------------------|
| Docker Engine  | 20.10.x          |
| docker-compose | 2.x              |
| Git (optional) | 2.34             |

---

## Structure

Each top-level folder represents a separate category of vulnerable service.   Inside each, there are one or more subdirectories named *Challenge-N*, each representing a self-contained scenario.

| Service       | Challenges | 
|---------------|------------|
| DNS           | 1-2        | 
| FTP           | 1-3        | 
| MySQL         | 1-4        | 
| SMB           | 1-2        | 
| SMTP          | 1          | 
| SNMP          | 1          |
| WEB           | 20+         | 


## Quick Start

- **Clone the repository (optional):**

  ```bash
  git clone https://github.com/InfoSecWarrior/Offensive-Pentesting-Lab.git
  ```
  ```bash
  cd Offensive-Pentesting-Lab
  ```

- **Choose the desired service and version**

  Example: FTP / Challenge‑1

  ```bash
  cd FTP/Challenge-1
  ```

- **Run the vulnerable container**

  ```bash
  docker run -d -p 21:21 -p 80:80 -p 2222:22 infosecwarrior/ftp:v1
  ```

The container will appear in `docker ps` and be accessible at `localhost`.


## docker-compose Example

To run **multiple services at once**, create a `docker-compose.yml` at the project root:

```yaml
version: "3.8"

services:
  dns:
    image: infosecwarrior/dns-lab:v2
    ports:
      - "53:53/udp"
      - "80:80"
    networks: [ labnet ]

  ftp:
    image: infosecwarrior/ftp:v1
    ports:
      - "21:21"
      - "80:8081"
      - "2222:2222"
    networks: [ labnet ]

networks:
  labnet:
    driver: bridge
```

- Start
```bash
docker compose up -d
```
- Stop
```bash
docker compose down
```


## Lab Exercise Workflow

1. **Reconnaissance:**  
   Use tools like `nmap`, `masscan`, `whatweb`, `dnsenum` to identify open ports and service versions.

2. **Vulnerability Identification:**  
   - Dictionary attacks (`hydra`, `medusa`)  
   - CVE discovery via service fingerprinting (`searchsploit`, `nuclei`)  

3. **Exploitation:**  
   - Use public exploits (`Exploit-DB`, `Metasploit`)  
   - Manual exploitation (buffer overflow, SQL injection, etc.)  

4. **Privilege Escalation:**  
   - Kernel-level local vulnerabilities  
   - Misconfigurations (`sudo`, `capabilities`, SUID, etc.)  


## Contributing

1. Fork the repository.  
2. Create a branch: `git checkout -b feature/your-feature`.  
3. Make changes and add a detailed README to your Challenge.  
4. Submit a Pull Request describing vulnerabilities and attack flow.