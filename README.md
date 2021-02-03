# docker-gophish-latest
Docker for the latest gophish with database backup

1. Edit the `.env` file to set the MYSQL passwords
2. Edit the `gophish/config.json` file to set the MYSQL password and user
3. `docker-compose up -d`
4. `docker-compose logs gophish`
5. Save the `admin` password printed in the logs
6. Login to administrative interface on port 3333
7. Change the `admin` password
8. Create the NGINX conf file for the domain
