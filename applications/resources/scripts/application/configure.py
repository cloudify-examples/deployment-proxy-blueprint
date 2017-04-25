#!/usr/bin/env python

import requests
from cloudify import ctx


def get_current_values(_endpoint, _key):
    response = \
        requests.get('{0}/v2/keys/{1}'.format(_endpoint, _key))
    return response.json()


def set_updated_values(_endpoint, _key, _value):
    response = \
        requests.put(
            '{0}/v2/keys/{1}'.format(_endpoint, _key),
            data=_value)
    return response.ok()


if __name__ == '__main__':

    endpoint = ctx.instance.runtime_properties.get('endpoint')
    key = ctx.instance.runtime_properties.get('key', 'node-instances')
    current_value = get_current_values(endpoint, key)
    new_value = {ctx.node.name: ctx.instance.id}
    if current_value:
        mutable = current_value['node']['value']
        mutable.update(new_value)
    else:
        mutable = new_value
    set_updated_values(endpoint, key, mutable)
