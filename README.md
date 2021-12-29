# docker-sneaky-gophish
Docker for the latest gophish with stealth configuration from [sneaky_gophish](https://github.com/puzzlepeaches/sneaky_gophish).

## Usage

1. Create your HTTPS certificate with:
   ````
   docker run -it --rm --name certbot -p 443:443 -p 80:80 -v "$(pwd)/ssl/:/etc/letsencrypt" -v "$(pwd)/var/lib/letsencrypt:/var/lib/letsencrypt/live" certbot/certbot certonly --standalone --agree-tos -d goo-gle.xyz -d www.goo-gle.xyz
3. Copy the private key to ./ssl/priv.key
4. Copy the public key to ./ssl/cert.crt
5. Edit the proxy configuration to match your domain editing `./proxies/goo-gle.xyz` (replace `goo-gle.xyz` with your domain)
6. Run `docker-compose up -d`
7. Run `docker-compose logs gophish` to check for errors and get the admin password
8. Save the `admin` password printed in the logs
9. Login to administrative interface on port 3443
10. The landing page will show up on ports 80 (it will redirect to HTTPS) and 443
