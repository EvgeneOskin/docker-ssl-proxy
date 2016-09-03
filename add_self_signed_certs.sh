mkdir /etc/nginx/certs/ || true
if [ ! -f "/etc/nginx/certs/key.pem" ]; then
    (
    cd /etc/nginx/certs/ || exit
    openssl genrsa -out key.pem 2048
    openssl req -new -sha256 -key key.pem -nodes -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=${DOMAIN_NAME:-www.example.com}" -out csr.pem
    openssl x509 -req -in csr.pem -signkey key.pem -out cert.pem
    )
fi
