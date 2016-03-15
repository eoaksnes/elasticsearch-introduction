#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
from logging import StreamHandler

from flask import Flask
import config
from elasticsearch import Elasticsearch

API_VERSION = "v1"


def create_app():
    flask_app = Flask(__name__)
    config.configure_app(flask_app)
    elasticsearch_url = flask_app.config['ELASTICSEARCH_URL']
    flask_app.elasticsearch = Elasticsearch(hosts=[elasticsearch_url])
    return flask_app


app = create_app()

if not app.debug:
    stream_handler = StreamHandler()
    app.logger.addHandler(stream_handler)

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 80))
    app.run(host='0.0.0.0', port=port, debug=True)
