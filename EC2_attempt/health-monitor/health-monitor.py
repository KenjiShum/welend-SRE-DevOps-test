import requests
import time

while True:
    try:
        response = requests.get('http://localhost:80')
        if response.status_code == 200:
            print('NGINX is up and running.')
        else:
            print('NGINX is not responding correctly.')
            # include a alert function e.g. send message to slack/email
    except requests.ConnectionError:
        print('NGINX is not running.')
    time.sleep(5)  # wait for 5 seconds before the next check