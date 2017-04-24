#!/usr/bin/env python

import os
from cloudify import ctx


if __name__ == '__main__':

    for file_path in ctx.instance.runtime_properties.get('cleanup', []):
        os.path.remove(file_path)
