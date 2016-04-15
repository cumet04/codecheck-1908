#!/usr/bin/python3
# -*- coding: utf-8 -*-

import requests
import yaml
import argparse
from logging import getLogger, StreamHandler, DEBUG

logger = getLogger(__name__)
handler = StreamHandler()
handler.setLevel(DEBUG)
logger.setLevel(DEBUG)
logger.addHandler(handler)


def load_projects(filename):
    file = open(filename, 'r')
    data = yaml.load(file)
    file.close()

    logger.info('load_config done')
    logger.info('input: {0}'.format(data))

    return data["projects"]

def fetch_thumb(url):
    tmp_file = '/tmp/__tmp_thumb.jpg'
    ep = 'http://capture.heartrails.com/400x300/border?{0}'.format(url)
    res = requests.get(ep)
    f = open(tmp_file, 'wb')
    f.write(res.content)
    f.close()
    return tmp_file


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('dest', default="http://localhost:3000", nargs='?',
                        help='dest addr:port')
    args = parser.parse_args()

    logger.info('destination addr: {0}'.format(args.dest))

    projects = load_projects("project_list.yml")

    for item in projects:
        # generate post params
        params = {
            'title': item['title'],
            'url': item['url'],
            'description': item['description'],
        }

        # fetch thumb file
        if 'thumb' not in item:
            item['thumb'] = fetch_thumb(item['url'])

        # open thumb file
        thumb_file = {
            'thumb': open(item['thumb'], 'rb')
        }

        # post
        path = '{0}/api/projects'.format(args.dest)
        res = requests.post(path, data=params, files=thumb_file)
        logger.info(res.status_code)

