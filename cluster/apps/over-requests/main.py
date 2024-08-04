# https://realpython.com/command-line-interfaces-python-argparse/

import argparse
import time
import sys

import requests


INTERVAL_SECONDS_DEFAULT = 0.001


parser = argparse.ArgumentParser()
parser.add_argument("path")
parser.add_argument("-l", "--long", action="store_true")
args = parser.parse_args()


print(args.long)
print(args.path)


# for i in range(10):
#     if len(sys.argv) == 1:
#         interval = INTERVAL_SECONDS_DEFAULT
#     else:
#         interval = float(sys.argv[1])
    
#     time.sleep(interval)
#     response = requests.get("http://localhost:8082/echo")

#     print(i, response.json())
