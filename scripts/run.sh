#!/bin/sh

set -e

python manage.py wait_for_db
python manage.py collectstatic --noinput
python manage.py migrate

# with tcp/port
# uwsgi --socket :9000 --workers 4 --master --enable-threads --module core.wsgi

# with sockets
uwsgi --socket /socks/django.sock --master --module core.wsgi --chmod-socket=777