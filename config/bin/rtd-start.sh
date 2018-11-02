#!/bin/bash -x

curl -XPUT 'http://elasticsearch:9200/readthedocs/'

cd /app/readthedocs
ln -s ../manage.py .

python manage.py syncdb --noinput
python manage.py migrate
echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@localhost', 'admin')" | python manage.py shell
python manage.py loaddata test_data
python manage.py makemessages --all
python manage.py compilemessages

export C_FORCE_ROOT="true"
python manage.py celeryd -l INFO &
python manage.py runserver 0.0.0.0:8000
