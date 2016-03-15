# -*- coding: utf-8 -*-

import json

from flask.ext.script import Manager
from app import app
import config

app.config.from_object(config.DevelopmentConfig)

manager = Manager(app)


@manager.command
def index_data():
    print("Indexing...")
    '''try:
        app.elasticsearch.indices.create(index='big-one', ignore=400)
        app.elasticsearch.cluster.health(wait_for_status='yellow', request_timeout=10)

        # Index the data
        with open('presentation-data.json') as data_file:
            data = json.load(data_file)
            for entry in data:
                app.elasticsearch.index(
                    index="big-one",
                    doc_type="pizza",
                    id=entry['id'],
                    body=entry['name'])

    except Exception, e:
        print "Indexing error: ", str(e)'''


if __name__ == '__main__':
    manager.run()
