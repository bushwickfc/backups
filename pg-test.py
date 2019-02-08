# python 2...
# import sys
# import urllib2
# import json

# def get_heroku_config(oath_token):
#     req = urllib2.Request('https://api.heroku.com/apps/bfc-owners/config-vars')
#     req.add_header('Authorization', 'Bearer {0}'.format(oath_token))
#     req.add_header('Accept', 'Accept: application/vnd.heroku+json; version=3')
#     resp = urllib2.urlopen(req)
#     return resp.read()

# heroku_config = json.loads(get_heroku_config(sys.argv[1]))
# db_url = heroku_config["HEROKU_POSTGRESQL_COBALT_URL"]

# print(db_url)


# python 3...
import sys
import urllib.request
import json
import ssl

# Without this, was getting an SSL: CERTIFICATE_VERIFY_FAILED error
# https://stackoverflow.com/questions/35569042/ssl-certificate-verify-failed-with-python3
ssl._create_default_https_context = ssl._create_unverified_context

def get_heroku_config(oath_token):
    url = 'https://api.heroku.com/apps/bfc-owners/config-vars'
    hdrs = { 'Authorization': 'Bearer {0}'.format(oath_token), 'Accept': 'application/vnd.heroku+json; version=3' }
    req = urllib.request.Request(url, headers=hdrs)
    response = urllib.request.urlopen(req)
    return json.loads(response.read())

heroku_config = get_heroku_config(sys.argv[1])
db_url = heroku_config['HEROKU_POSTGRESQL_COBALT_URL']
print(db_url)
