#!/bin/bash
cd $APPDIR

set -e

unzip /tmp/master.zip -d /tmp >/dev/null 2>/dev/null 
yes | cp -i -a /tmp/readthedocs.org-master/* . 

cp -f /etc/default/rtd-config.py $APPDIR/readthedocs/config.py
cp -f /etc/default/rtd-config.py $APPDIR/readthedocs/settings/local.py

pip install -U -r $APPDIR/requirements.txt
cd $APPDIR && /venv/bin/python setup.py develop
cd $APPDIR/readthedocs
chown -R py $APPDIR
pip install psycopg2 git+https://github.com/rtfd/readthedocs-sphinx-ext.git
ln -s /app/readthedocs/core/static /app/media/
mkdir -p /app/prod_artifacts/media
