#!/usr/bin/env python

import os
import stat
import urllib
import zipfile
import tempfile
from cloudify import ctx
from cloudify.exceptions import NonRecoverableError


def update_cleanup(file_path):
    ctx.logger.info('Update cleanup.')
    if 'cleanup' not in ctx.instance.runtime_properties.keys():
        ctx.instance.runtime_properties['cleanup'] = []
    cleanup = ctx.instance.runtime_properties['cleanup']
    cleanup.append(file_path)
    ctx.instance.runtime_properties['cleanup'] = cleanup


def download_archive(_url):
    ctx.logger.info('Download archive.')

    temp_directory = tempfile.mkdtemp()
    update_cleanup(temp_directory)
    temp_file = os.path.join(temp_directory, 'archive')

    try:
        urllib.urlretrieve(archive_url, temp_file)
    except:
        raise NonRecoverableError()

    return temp_file


def unpack_archive(file_path, target_path, compression_type):
    ctx.logger.info('Unpack archive.')

    if 'zip' in compression_type:
        zip_archive = zipfile.ZipFile(file_path, 'r')
        zip_archive.extractall(target_path)
        zip_archive.close()
        return True
    else:
        raise NonRecoverableError(
            'Unsupported compression_type: {0}'
            .format(compression_type))


def change_permissions(file_path):
    ctx.logger.info('Change permissions.')
    st = os.stat(file_path)
    os.chmod(file_path, st.st_mode | stat.S_IEXEC)
    return True


if __name__ == '__main__':

    # Initialize the resource context
    ctx.instance.runtime_properties['software_package'] = {}

    # Get the software package config
    sp_config = ctx.node.properties.get('resource_config')

    # Get the binary object config
    bn_config = sp_config.get('binary_object')

    # Get the name of the software package
    sp_name = sp_config.get('name')

    # Get the URL of the software package artifact
    archive_url = bn_config.get('archive_url')

    # Get the compression of the artifact if it exists
    gz = bn_config.get('archive_compression_format')

    # Get the system path to the binary
    system_path = sp_config.get('system_path_directory')

    # Download the archive
    archive_path = download_archive(archive_url)

    # Unpack the archive to the system path
    unpack_archive(archive_path, system_path, gz)

    # Make the binary executable
    binary_file = os.path.join(system_path, sp_name)
    change_permissions(binary_file)
    update_cleanup(binary_file)
