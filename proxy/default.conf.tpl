upstream django {
    server unix:///code/socks/django.sock;

    #server 127.0.0.1:8000;
}

server {
    listen ${LISTEN_PORT};

    location /static {
        alias /vol/static;
    }

    location / {
        # uwsgi_pass ${APP_HOST}:${APP_PORT};
        uwsgi_pass django;
        include /etc/nginx/uwsgi_params;
        client_max_body_size 10M;
    }
}