#!/usr/bin/env python

# save top 10 google image search results to current directory
# https://developers.google.com/custom-search/json-api/v1/using_rest

import os
import sys
import re
import shutil
import json
import requests

os.environ['SERVER_KEY']='AIzaSyCaPYqnvr_rfgtXEu4VtfHkAJ7F7kYUSf0' 
os.environ['CUSTOM_SEARCH_ID']='013941156354834928564:tezifyye-9m'

print os.environ['SERVER_KEY']
print os.environ['CUSTOM_SEARCH_ID']

#url='https://www.googleapis.com/customsearch/v1?key=SERVER_KEY&cx=CUSTOM_SEARCH_ID&q=flower&searchType=image&fileType=jpg&imgSize=xlarge&alt=json'
#url = 'https://www.googleapis.com/customsearch/v1?&num=10&start=11&key={}&cx={}&searchType=image&q={}&searchType=image&fileType=jpg&imgSize=xlarge&alt=json'
url = 'https://www.googleapis.com/customsearch/v1?&num=10&start={}&key={}&cx={}&searchType=image&q={}&searchType=image&fileType=jpg&imgSize=xlarge&alt=json'

apiKey = os.environ['SERVER_KEY']
cx = os.environ['CUSTOM_SEARCH_ID']
q = sys.argv[1]
n = int(sys.argv[2])

print q
print n

k = 1
c = 1
nr = 0
for c in range(n):
  i = 1
  print k
  for result in requests.get(url.format(k,apiKey, cx, q)).json()['items']:
    link = result['link']
    image = requests.get(link, stream=True)
    if image.status_code == 200:
      m = re.search(r'[^\.]+$', link)
      nr=k+i
      filename = './{}-{}.{}'.format(q, nr, m.group())
      with open(filename, 'wb') as f:
        image.raw.decode_content = True
        shutil.copyfileobj(image.raw, f)
      i += 1
  c+=1
  k+=i