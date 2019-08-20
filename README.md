# testapp-ssl-self-signed-docker
Test Application to illustrate Self Signed Certs/Keys using OpenSSL, Python's Flask and Docker.

```
Generate a Self Signed Certificate and Private Key using OpenSSL:
$ openssl req -x509 -newkey rsa:4096 -nodes -out cert.pem -keyout key.pem -days 365


Generating a 4096 bit RSA private key
.................................................................................++
................................................................++
writing new private key to 'key.pem'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:US
State or Province Name (full name) []:California
Locality Name (eg, city) [Default City]:Los Angeles
Organization Name (eg, company) [Default Company Ltd]:DMCC
Organizational Unit Name (eg, section) []:
Common Name (eg, your name or your server's hostname) []:localhost
Email Address []:


$ ls -l
-rw-rw-r--. 1 centos centos 1980 Aug 19 22:29 cert.pem
-rw-rw-r--. 1 centos centos 3272 Aug 19 22:29 key.pem
 

$ sudo docker build . -t rgdevops123/testapp-ssl-self-signed
$ sudo docker run -d --rm --name testapp-ssl-self-signed -p 5000:5000 rgdevops123/testapp-ssl-self-signed


This option is also available through the Flask CLI:
$ flask run --cert=cert.pem --key=key.pem



   Production Servers:

$ sudo yum -y install python36-devel openssl-devel

$ sudo pip3 install flask gunicorn pyopenssl

$ vim app.py
+++
    app.run(host='0.0.0.0)
+++

$ vim wsgi.py 
+++
from app import app

if __name__ == "__main__":
    app.run()
+++


$ gunicorn --certfile cert.pem --keyfile key.pem -b 0.0.0.0:8000 wsgi:app


GOTO: https://devopsweb:8000
```
