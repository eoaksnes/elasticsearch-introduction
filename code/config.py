import os


class Config(object):
    DEBUG = False
    TESTING = False
    CSRF_ENABLED = True
    ELASTICSEARCH_URL = os.environ.get('ELASTICSEARCH_URL', 'elasticsearch:9200')


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True


class TestingConfig(Config):
    # The TESTING configuration flag disables the error catching
    # during request handling so that you get better error reports when issuing requests.
    TESTING = True
    DEBUG = True
    PRESERVE_CONTEXT_ON_EXCEPTION = False


config = {
    "development": DevelopmentConfig,
    "testing": TestingConfig,
}


def configure_app(app):
    config_name = os.getenv('ENVIRONMENT', 'default')
    app.config.from_object(config[config_name])
