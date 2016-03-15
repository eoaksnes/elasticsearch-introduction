import time

from app import create_app
from tests_bdd.results import print_overview_errors, print_overview_features

app = create_app()


def before_scenario(context, scenario):
    context.client = app.test_client()
    context.ctx = app.test_request_context()
    context.ctx.push()
    context.app = app


def after_scenario(context, scenario):
    context.ctx.pop()


def before_all(context):
    context.start = time.time()
    context.errors = []
    context.features = []


def after_all(context):
    print_overview_features(context.features)
    print_overview_errors(context.errors)
    print("Total time: %s \n" % str(time.time() - context.start))


def after_feature(context, feature):
    context.features.append(feature)


def after_step(context, step):
    if step.status == 'failed':
        context.errors.append(step)
