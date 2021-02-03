# docker-gophish-latest
Docker for the latest gophish with database backup

1. `docker-compose up -d`
2. `docker-compose logs gophish`
3. Save the `admin` password printed in the logs
4. Login to administrative interface on port 3333
5. Change the `admin` password
6. Create the NGINX conf file for the domain
