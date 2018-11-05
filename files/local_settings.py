# Setting Overrides
# See readthedocs/settings/*.py for settings that need to be modified
import os

# Set this to the root domain where this RTD installation will be running
#PRODUCTION_DOMAIN = os.getenv('RTD_PRODUCTION_DOMAIN', 'localhost:8000')

# Set the Slumber API host
#SLUMBER_API_HOST = os.getenv('RTD_SLUMBER_API_HOST', "http://" + PRODUCTION_DOMAIN)

# Turn off email verification
ACCOUNT_EMAIL_VERIFICATION = 'none'

# Enable private Git doc repositories
ALLOW_PRIVATE_REPOS = True

SECRET_KEY = os.environ['SECRET_KEY'] or "the_secret_key_12345"

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': os.environ['DB_ENV_DB_NAME'],
        'USER': os.environ['DB_ENV_DB_USER'],
        'PASSWORD': os.environ['DB_ENV_DB_PASS'],
        'HOST': 'db',
        'PORT': 5432,
    }
}
SITE_ROOT = '/app'
ES_HOSTS = ['elasticsearch:9200']
REDIS = {
    'host': 'redis',
    'port': 6379,
    'db': 0,
}

BROKER_URL = 'redis://redis:6379/0'
CELERY_RESULT_BACKEND = 'redis://redis:6379/0'
DEBUG = True
CELERY_ALWAYS_EAGER = False