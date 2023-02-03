# MK.CertificateGenerator

A tool to create self signed Certificate Authority and Server Certificate using OpenSSL.
Note: Those certificates should only be used for private/development usage! Use an offical CA for your public pages!

Was tested February 2022 with iOS Version 15.2.1, macOS 11.2.2 and Windows 10.

Kudos to [TechSchool](<https://www.youtube.com/c/TECHSCHOOLGURU/about>). Their video [Create & sign SSL/TLS certificates with openssl](<https://youtu.be/7YgaZIFn7mY>) was used as a source to generate this tool.

## Usage

1. Clone Repo
1. Add all required url´s to server-ext.cnf
1. Update line 10 with data of your own CA. The values must not be realistic domains/names.
1. Update line 16 with data of your server. So enter the planned domain (e.g. myserver.mydomain.com). The values must not be realistic domains/names but if you configure it in your own domain, you cannot reach them in the public Internet anymore.
1. Run `chmod +x gen.sh` - This makes the script executable
1. Run `./gen.sh`
1. Generated documents should appear in same folder

* ca-cert.srl --> Serialnumber of the generated CA
* ca-cert.pem --> The CA´s certificate used for server certificate generation
* ca-key.pem --> The CA´s private key used for server certificate generation
* server-req.pem --> The request created via line 16
* serer-cert.pem --> The server certificate
* server-key.pem --> The server private key
