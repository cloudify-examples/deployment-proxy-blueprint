#!/usr/bin/env python

from cloudify import ctx

if __name__ == '__main__':
    dep = ctx.target.instance.runtime_properties.get('deployment')
    outputs = dep.get('outputs')
    url = outputs.get('DISCOVERY_URL')
    ctx.instance.runtime_properties['DISCOVERY_URL'] = url
