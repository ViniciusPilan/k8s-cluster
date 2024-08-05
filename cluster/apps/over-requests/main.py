# https://realpython.com/command-line-interfaces-python-argparse/
# Lead with exception
# Lead with LOGs

import argparse
import time
import sys

import requests


def init_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("url", help="URL to make the overload.")
    parser.add_argument("interval", help="Interval between requests (in seconds).")
    parser.add_argument(
        "--amount", 
        help="Amount of the requests that will be made. Let empty to be an infinity loop.")
    return parser.parse_args()    


if __name__ == "__main__":
    args = init_args()

    i = 0
    url = args.url
    interval = float(args.interval)
    amount = -1

    if args.amount is not None:
        amount = int(args.amount)

    while True:
        if i == amount:
            break
        
        time.sleep(interval)

        try:
            response = requests.get(url)
            print(f"{i} {response.json()}")
        except:
            print(f"{i} Request failed")

        i += 1
