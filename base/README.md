# base

## Quick Start

```console
docker container run -it --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd)/.config/gcloud:/root/.config/gcloud \
  ryutah/develop-environment bash
```

## Git設定

コンテナを実行するカレントディレクトリに、次のようにファイルを作成する

```txt
.config
└── git
    ├── .git.store
    └── .gitconfig
```

各ファイルを次のように設定する

### .gitconfig

```gitconfig
[user]
  email = [YOUR_EMAAIL]
  name = [YOUR_NAME]
[credential]
  helper = store --file /root/.config/git/.git.store
[credential "https://source.developers.google.com"]
  helper = gcloud.sh
[url "https://github.com/"]
  insteadOf = git@github.com:
```

### .git.store

```txt
https://[GITHUB_USER_NAME]:[PERSONAL_ACCESS_TOKEN]@github.com
```

### 設定をマウントしてコンテナを実行する

```console
docker container run -it --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd)/.config/gcloud:/root/.config/gcloud \
  -v $(pwd)/.config/git/.git.store:/root/.config/.git.store \
  -v $(pwd)/.config/git/.gitconfig:/root/.gitconfig \
  ryutah/develop-environment bash
```
