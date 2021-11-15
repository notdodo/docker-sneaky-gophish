# docker-sneaky-gophish
Docker for the latest gophish with stealth configuration from [sneaky_gophish](https://github.com/puzzlepeaches/sneaky_gophish).

## Usage

1. Create your HTTPS certificate with: `docker run -it --rm --name certbot -p 443:443 -p 80:80 -v "./ssl/:/etc/letsencrypt" -v "./var/lib/letsencrypt:/var/lib/letsencrypt" certbot/certbot certonly -d goo-gle.xyz -d www.goo-gle.xyz`
2. Copy the private key to ./ssl/priv.key
3. Copy the public key to ./ssl/cert.crt
4. Edit the proxy configuration to match your domain editing `./proxies/goo-gle.xyz` (replace `goo-gle-xyz` with your domain)
5. Run `docker-compose up -d`
5. Run `docker-compose logs gophish` to check for errors and get the admin password
5. Save the `admin` password printed in the logs
6. Login to administrative interface on port 3443
7. The landing page will show up on ports 80 (it will redirect to HTTPS) and 443
