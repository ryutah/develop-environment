FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    DOCKER_VERSION=5:19.03.12~3-0~ubuntu-focal \
    DOCKER_COMPOSE_VERSION=1.26.2 \
    GCLOUD_SDK_VERSION=303.0.0 \
    GO_TASK_VERSION=2.8.1

# Install Docker
RUN apt-get update \
 && apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
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
      containerd.io \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

## Install Docker Compose
RUN curl -sL "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
 && chmod +x /usr/local/bin/docker-compose

# Install Google Cloud SDK
WORKDIR /usr/local/lib
RUN curl -s -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
 && tar xzf google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz google-cloud-sdk \
 && ./google-cloud-sdk/install.sh --quiet --additional-components kind kubectl kustomize skaffold \
 && ./google-cloud-sdk/bin/kubectl completion bash > /etc/bash_completion.d/kubectl \
 && ./google-cloud-sdk/bin/kind completion bash > /etc/bash_completion.d/kind \
 && rm -f google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz

# Install tools(with apt-get)
RUN apt-get update \
 && apt-get install -y \
      bash-completion \
      git \
      hub \
      jq \
      vim \
      wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install go-task/task
RUN curl -sL https://taskfile.dev/install.sh | sh -s -- -b /usr/local/bin v${GO_TASK_VERSION}

# Setup prompt
ADD https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh /root/.git-prompt.sh
COPY base/.bashrc /root/.bashrc

COPY base/.gitconfig /root/.gitconfig

WORKDIR /root
