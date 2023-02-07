# Install NGINX on Ubuntu 22.04 LTS

### Update packages and install nginx
```bash
sudo ap-get -y update
sudo apt install -y nginx
```

### Enable firewall to allow traffic on http and http ports
```bash
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw allow http
sudo ufw allow https
```

### Commands on Nginx
```bash
# stop  nginx
sudo systemctl stop nginx

# start nginx
sudo systemctl start nginx

# verify the configuration is ok in nginx
sudo nginx -t

# restart nginx
sudo systemctl restart nginx

# reload configuration
sudo systemctl reload nginx

# disable nginx service
sudo systemctl disable nginx

# enable nginx service
sudo systemctl enable nginx

```

### create a backup of your default configurtion file
```bash
sudo cp /etc/nginx/sites-available/default  /etc/nginx/sites-available/default.20221006.bak
```