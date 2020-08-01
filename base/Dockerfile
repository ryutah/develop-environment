FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    DOCKER_VERSION=5:19.03.12~3-0~ubuntu-focal \
    DOCKER_COMPOSE_VERSION=1.26.2 \
    GCLOUD_SDK_VERSION=303.0.0

# Install Docker
RUN apt-get update \
 && apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
 && apt-key fingerprint 0EBFCD88 \
 && add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable" \
 && apt-get update \
 && apt-get install -y \
      docker-ce=${DOCKER_VERSION} \
      docker-ce-cli=${DOCKER_VERSION} \
      containerd.io

# Install Google Cloud SDK
WORKDIR /usr/local/lib
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
 && tar zxvf google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz google-cloud-sdk \
 && ./google-cloud-sdk/install.sh --quiet --additional-components kind kubectl kustomize skaffold\
 && echo "source /usr/local/lib/google-cloud-sdk/completion.bash.inc" >> /root/.bashrc \
 && echo "source /usr/local/lib/google-cloud-sdk/path.bash.inc" >> /root/.bashrc \
 && rm -f google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz

WORKDIR /root
