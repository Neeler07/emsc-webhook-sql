from __future__ import unicode_literals

from tornado.websocket import websocket_connect
from tornado.ioloop import IOLoop
from tornado import gen

import logging
import json
import sys
import os, time
import mysql.connector

from datetime import datetime

os.environ['TZ'] = 'Europe/London'

echo_uri = 'wss://www.seismicportal.eu/standing_order/websocket'
PING_INTERVAL = 15

# SQL
mydb = mysql.connector.connect(
  host = "localhost",
  user = "user",
  passwd = "xxxx",
  database = "quaker"
)

#You can modify this function to run custom process on the message
def myprocessing(message):
    try:
        logging.info('Origin MSG: %s',message)
        data = json.loads(message)
        info = data['data']['properties']
        info['action'] = data['action']
        logging.info('>>>> {action:7} event from {auth:7}, unid:{unid}, T0:{time}, Mag:{mag}, Region: {flynn_region}'.format(**info))


        # lastupdate
        datetime_obj = datetime.strptime(
            data['data']['properties']['lastupdate'], '%Y-%m-%dT%H:%M:%S.%fZ'
        )
        lastupdate = datetime_obj.strftime('%s')

        #time
        datetime_obj = datetime.strptime(
            data['data']['properties']['time'], '%Y-%m-%dT%H:%M:%S.%fZ'
        )
        time = datetime_obj.strftime('%s')

        mycursor = mydb.cursor()

        sql = "INSERT INTO `earthquakes_seismic` SET `eventid` = %s, `type` = %s, `lastupdate` = %s, `magtype` = %s, `evtype` = %s, `lon` = %s, `lat` = %s, `depth` = %s, `auth` = %s, `mag` = %s, `time` = %s, `source_id` = %s, `source_catalog` = %s, `flynn_region` = %s, `status` = %s"

        val = (
            data['data']['id'],
            data['data']['type'],
            lastupdate,
            data['data']['properties']['magtype'],
            data['data']['properties']['evtype'],
            data['data']['properties']['lon'],
            data['data']['properties']['lat'],
            data['data']['properties']['depth'],
            data['data']['properties']['auth'],
            data['data']['properties']['mag'],
            time,
            data['data']['properties']['source_id'],
            data['data']['properties']['source_catalog'],
            data['data']['properties']['flynn_region'],
            data['action']

        )

        try:
                mycursor.execute(sql, val)
                mydb.commit()
        except:
                print(mycursor._last_executed)
                sys.exit()


    except Exception:
        logging.exception("Unable to parse json message")

@gen.coroutine
def listen(ws):
    while True:
        msg = yield ws.read_message()
        if msg is None:
            logging.info("close")
            ws = None
            sys.exit()
        myprocessing(msg)

@gen.coroutine
def launch_client():
    try:
        logging.info("Open WebSocket connection to %s", echo_uri)
        ws = yield websocket_connect(echo_uri, ping_interval=PING_INTERVAL)
    except Exception:
        logging.exception("connection error")
        sys.exit()
    else:
        logging.info("Waiting for messages...")
        listen(ws)

if __name__ == '__main__':
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)
    ioloop = IOLoop.instance()
    launch_client()
    try:
        ioloop.start()
    except KeyboardInterrupt:
        logging.info("Close WebSocket")
        ioloop.stop()
        sys.exit()
