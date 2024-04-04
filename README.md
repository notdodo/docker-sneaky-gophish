# docker-sneaky-gophish

Docker for the latest gophish with stealth configuration from [sneaky_gophish](https://github.com/puzzlepeaches/sneaky_gophish) using Caddy as a reverse proxy for autossl features.

## Usage

1. Edit the proxy configuration to match your domain editing `./caddy/Caddyfile` (replace `goo-gle.xyz` with your domain)
2. Copy `env_example` in `.env`
3. Edit `.env`
4. Run `docker compose up -d`
5. Run `docker compose logs gophish` to check for errors and get the admin password
6. Save the `admin` password printed in the logs
7. Login to administrative interface on port 3443
8. The landing page will show up on ports 80 (it will redirect to HTTPS) and 443
