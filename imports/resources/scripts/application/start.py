#!/usr/bin/env python

import requests
from cloudify import ctx


def get_current_values(_endpoint, _key):
    response = \
        requests.get('{0}/v2/keys/{1}'.format(_endpoint, _key))
    return response.json()


if __name__ == '__main__':

    endpoint = ctx.instance.runtime_properties.get('endpoint')
    key = ctx.instance.runtime_properties.get('key')

    current_value = get_current_values(endpoint, key)
    ctx.logger.info('Current {0} value: {1}'.format(key, current_value))
