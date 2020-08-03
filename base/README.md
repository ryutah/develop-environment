# base

## Quick Start

```console
bash <(curl -sL https://raw.githubusercontent.com/ryutah/develop-environment/master/initialize.sh)
Input Your Git name:
[YOUR_NAME]
Input Your Git email:
[YOUR_EMAIL]

docker container run -it --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd)/.config:/root/.config \
  ryutah/develop-environment bash
```

## Tips

### Git設定

#### Credential Helperを利用するy

コンテナを実行するカレントディレクトリに `.git.store` を作成する

```txt
.config
└── git
    ├── .git.store
    └── .gitconfig
```

##### .git.store

クレデンシャルを保持するファイル。
**パーソナルアクセストークンを記載する必要があるが、特に暗号化などされてないので管理には要注意**

```txt
https://[GITHUB_USER_NAME]:[PERSONAL_ACCESS_TOKEN]@github.com
```

##### .gitconfig

credential helperを設定し、GitHubのアクセスをsshではなくhttpsで行うように変更する

```gitconfig
[user]
  email = [YOUR_EMAAIL]
  name = [YOUR_NAME]
[credential]
  helper = store --file /root/.config/git/.git.store
[url "https://github.com/"]
  insteadOf = git@github.com:
```
