mkdir /etc/nginx/certs/ || true
if [ ! -f "/etc/nginx/certs/key.pem" ]; then
    (
    cd /etc/nginx/certs/ || exit
    openssl genrsa -out key.pem 2048


    if test -n "${ADITIONAL_NAMES_CSV}"; then
        cp /etc/ssl/openssl.cnf openssl.cnf
        sed 's/,/,DNS:/g' >> openssl.cnf <<EOF
[SAN]
subjectAltName=DNS:${ADITIONAL_NAMES_CSV}
EOF
        openssl req -new -sha256 -key key.pem -nodes \
            -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=${DOMAIN_NAME:-www.example.com}" \
            -reqexts SAN -config openssl.cnf \
            -out csr.pem
        openssl x509 -req -in csr.pem \
            -extensions SAN -extfile openssl.cnf \
            -signkey key.pem -out cert.pem
    else
        openssl req -new -sha256 -key key.pem -nodes \
            -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=${DOMAIN_NAME:-www.example.com}" \
            -out csr.pem
        openssl x509 -req -in csr.pem -signkey key.pem -out cert.pem
    fi

    )
fi
