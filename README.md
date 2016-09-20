# docker-ssl-proxy
Builds a basic nginx server that proxies incoming SSL calls to a target
docker.

## Usage

Image support environment variables to tune up self-signed certificate:
- `DOMAIN_NAME`, e.g. `example.com`
- `ADITIONAL_NAMES_CSV`, e.g. `www.example.com,*.www.example.com`

### Build and Run the Proxy ###
Build the docker:

    sh build.sh [-d Target Docker (Default: bixel)]

Run the docker:

    sh build.sh [-p SSL Port (default: 443)] [-d Target Docker (Default:
    bixel)] [-t Target Docker Port (Default: 80)]

### Docker Hub Image ###
You can get the publicly available docker image at the following location: [Docker Hub - SSL-Proxy](https://registry.hub.docker.com/u/cbachich/docker-ssl-proxy/)
