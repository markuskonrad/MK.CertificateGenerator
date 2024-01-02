# Remove existing .pem and .srl files in the current folder.
rm *.pem
rm *.srl

# 1. Generate CA´s private key and self-signed certificated
# - The 'nodes' option avoids password (for dev and internal use only and required if used in Synology)
# - The 'days' option must be less or equal to 825 to support Apple´s 'Requirements for trusted certificates' (https://support.apple.com/en-us/HT210176)
# - The 'sha256' value is important and must be of family 2xx. SHA1 is not supported by most Operating Systems anymore
# - Change the over values to fit to your needs
openssl req -x509 -newkey rsa:4096 -days 700 -sha256 -nodes -keyout ca-key.pem -out ca-cert.pem -subj "/C=DE/ST=YOURCOUNTRY/L=YOURCITY/O=YOURCANAME/OU=YOUROU/CN=*.YOURCADOMAIN.com/emailAddress=YOU@YOURAUTHORITY.com"
echo "CA´s self-signed certificate:"
openssl x509 -in ca-cert.pem -noout -text # Subject for next command can be fetched from here

# 2. Generate web server´s private key and signing request (CSR)
# - No days value here, since this is not a Cert but a Certificate Signing Request
openssl req -newkey rsa:4096 -nodes -keyout server-key.pem -out server-req.pem -subj "/C=DE/ST=YOURCOUNTRY/L=YOURCITY/O=YOURSERVERNAME/OU=YOUROU/CN=*.YOURSERVERDOMAIN.com/emailAddress=INFO@YOURSERVERDOMAIN.com"

# 3. Use CA´s private key to sign web server´s CSR and get back the signed certificate
# - Including also SAN information via configuration file 'server-ext.cnf'
openssl x509 -req -days 700 -sha256 -in server-req.pem -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile server-ext.cnf
echo "Server´s self-signed certificate:"
openssl x509 -in server-cert.pem -noout -text

# 4. Verify Certificate
echo "Verify is Cert is valid:"
openssl verify -CAfile ca-cert.pem server-cert.pem

# 5. Convert ca-cert.pem to CER file (Windows)
openssl x509 -in ca-cert.pem -outform pem -outform der -out ca-cert.cer