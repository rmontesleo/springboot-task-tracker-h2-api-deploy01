

### Create the tasktrackerapp.com file 
```bash
sudo vim /etc/nginx/conf.d/tasktrackerapp.con
```

###
```bash

server {
  listen 80;
  listen [::]:80;

  server_name tasktrackerapp.com;

  location / {
      proxy_pass http://localhost:8080/;
  }
}

```


### validate your nginx configuration
```bash
sudo nginx -t
```

### restart your nginx server
```bash
sudo service nginx restart
```