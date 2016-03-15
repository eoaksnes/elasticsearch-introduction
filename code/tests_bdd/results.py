import textwrap

from terminaltables import AsciiTable
from colorclass import Color


def colored_status(status, text):
    if status == u'passed':
        return Color('{autogreen}%s{/autogreen}' % text)
    elif status == u'skipped':
        return Color('{autocyan}%s{/autocyan}' % text)
    else:
        return Color('{autored}%s{/autored}' % text)


def two_decimals(number):
    return "{0:.2f}".format(number)


def print_overview_features(features):
    table_data = [['Feature', 'Scenario', 'Duration']]
    for feature in features:
        for scenario in feature.scenarios:
            table_data.append([feature.filename,
                               colored_status(scenario.status, scenario.name),
                               two_decimals(scenario.duration)])
    table = AsciiTable(table_data)
    print(table.table)


def print_overview_errors(errors):
    print("Errors: %s" % len(errors))

    for error in errors:
        table_data = [
            ['Feature', 'Step', 'Line', 'Error message'],
            [error.filename, error.name, str(error.line), '']
        ]
        table = AsciiTable(table_data)
        error_message_max_width = table.column_max_width(3)
        w = textwrap.TextWrapper(width=error_message_max_width, break_long_words=False,replace_whitespace=False)
        wrapped_string = '\n'.join(w.wrap(error.error_message))
        print(wrapped_string)
        table.table_data[1][3] = wrapped_string
        print(table.table)
