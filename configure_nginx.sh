PORT=${PORT:-443}
TARGET_PORT=${TARGET_PORT:-80}
CLIENT_MAX_BODY_SIZE=${CLIENT_MAX_BODY_SIZE:-20M}

echo "Starting Proxy: $PORT"
echo "Target Docker Port: $TARGET_PORT"

sh /add_self_signed_certs.sh

sed < nginx.conf.template "s|{{listenPort}}|$PORT|g" | \
    sed "s|{{targetPort}}|$TARGET_PORT|g" | \
    sed "s|{{clientMaxBodySize}}|$CLIENT_MAX_BODY_SIZE|g" > /etc/nginx/nginx.conf

# Use exec so nginx can get signals directly
exec nginx
echo "Something Broke!"
