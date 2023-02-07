
### create your folder for your app demo_domain
```bash
sudo mkdir /var/www/demo_domain 
```


```bash
sudo chmod -R 755 /var/www/demo_domain/
```

### create your index file
```bash
vim /var/www/demo_domain/index.html
```

### create the demo_domain configuration file
```bash
sudo vim /etc/nginx/sites-available/demo_domain
```

### configuration of the domain
```bash

server {
        listen 80;
        listen [::]:80;

        root /var/www/demo_domain/html;
        index index.html index.htm index.nginx-debian.html;

        server_name demo_domain www.demo_domain;

        location / {
                try_files $uri $uri/ =404;
        }
}

```


### Create simbolic link for the configuration
```bash
sudo ln -s /etc/nginx/sites-available/demo_domain /etc/nginx/sites-enabled/
```