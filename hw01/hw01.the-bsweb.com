
#Config file for the sub domain for HW01
#This code is referred from the default config file for Ubuntu 16.04

server {
        listen 80;
        listen [::]:80;

        root /home/burhan/www/hw01/;

        index index.html;

        server_name hw01.the-bsweb.com;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ =404;
        }
}

