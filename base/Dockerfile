FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    DOCKER_VERSION=5:19.03.12~3-0~ubuntu-focal \
    GCLOUD_SDK_VERSION=303.0.0-0

# Install Docker Dependencies
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

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
 && apt-get install -y apt-transport-https ca-certificates gnupg \
 && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
 && apt-get update \
 && apt-get -y install google-cloud-sdk=${GCLOUD_SDK_VERSION} \
 && echo "source /usr/lib/google-cloud-sdk/completion.bash.inc" >> /root/.bashrc
