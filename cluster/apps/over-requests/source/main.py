# https://realpython.com/command-line-interfaces-python-argparse/
# Lead with exception
# Lead with LOGs

import argparse
import logging
import time
import sys

import requests


def init_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("url", help="URL to make the overload.")
    parser.add_argument("interval", help="Interval between requests (in seconds).")
    parser.add_argument(
        "--time", 
        help="Total time that the requests will be made. Let empty to be an infinity loop.")
    parser.add_argument("--log", help="Log level.")
    return parser.parse_args()


def init_logger(log_level):
    level = "INFO"

    if log_level.upper() == "DEBUG":
        level = logging.DEBUG

    if log_level.upper() == "ERROR":
        level = logging.ERROR

    if log_level.upper() == "WARNING":
        level = logging.WARNING


    logging.basicConfig(
        level=level,
        format='%(asctime)s %(levelname)s %(message)s',
        filename='log.log',
        filemode='a'
    )


if __name__ == "__main__":
    
    args = init_args()
    init_logger(str(args.log))

    i = 0
    url = args.url
    interval = float(args.interval)
    total_amount = -1

    logging.info(f"url: {url}")
    logging.info(f"interval: {interval} seconds")
    logging.info(f"time: {args.time} seconds")
    logging.info(f"log level: {str(args.log)}")

    if args.time is not None:
        total_amount = float(args.time)/interval

    logging.info(f"total_amount: {total_amount} requests")

    while True:
        if i == total_amount:
            break
        
        time.sleep(interval)

        try:
            response = requests.get(url)
            logging.debug(f"{i} {response.json()}")
        except:
            logging.error(f"{i} Request failed")

        i += 1
