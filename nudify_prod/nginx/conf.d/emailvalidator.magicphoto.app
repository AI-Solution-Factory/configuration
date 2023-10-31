server {
    listen 80;
    listen [::]:80;
    server_name emailvalidator.magicphoto.app;
    # enforce https
    return 301 https://$server_name:443$request_uri;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name emailvalidator.magicphoto.app;
    ssl_certificate /etc/nginx/ssl/cfmagicphotoapp.crt;
    ssl_certificate_key /etc/nginx/ssl/cfmagicphotoapp.key;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    location / {
        proxy_pass http://127.0.0.1:3100;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}