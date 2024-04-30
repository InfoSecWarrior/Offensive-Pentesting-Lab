docker run -d --name mysql -p 8080:8080 -p 3306:3306 infosecwarrior/mysql-lab:v3

docker exec -it mysql service mariadb start
