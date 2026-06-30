FROM docker.io/debian:13

# Setup AWS CLI
COPY --from=docker.io/amazon/aws-cli:latest /usr/local/aws-cli /usr/local/aws-cli
ENV PATH="/usr/local/aws-cli/v2/current/bin:$PATH"

# Setup JQ
COPY --from=ghcr.io/jqlang/jq:1.8.1 /jq /usr/local/bin/jq

# Setup Kubectl
COPY --from=registry.k8s.io/kubectl:v1.35.3 /bin/kubectl /usr/local/bin/kubectl

# Setup Python
COPY --from=ghcr.io/thredd-platform/oci-python:latest / /

# Setup Node
COPY --from=ghcr.io/thredd-platform/oci-node:latest / /

# Setup tfswitch
COPY --from=ghcr.io/thredd-platform/oci-tfswitch:latest / /

# Setup terramate
COPY --from=ghcr.io/thredd-platform/oci-terramate:latest / /

RUN apt-get update && apt-get install -y \
    ca-certificates \
    libsqliteodbc \
    unixodbc-dev \
    libffi-dev \
    musl-dev \
    curl \
    grep \
    make \
    wget \
    gcc \
    git \
    zip
