# はじめに

色々検証する用です！(◍•ᴗ•◍)

# 環境構築

## 前提

・docker が使えること。(docker run hello-world が問題なく動く状態)<br>
※dockerコマンドは『docker desktop』で入れてください。
・make コマンドが使えること。

- 共有事項

```
nest 作成したものあらかじめ入れています。
詳細気になる場合右記参考 =>『nest プロジェクト作成まで』
```

## 起動

```
$ make start
```

## アプリ起動やり直しのみ

```
$ make app_start

or

$ docker-compose up --build -d

$ docker exec -i -t mysql99 bash
$ mysql -u root -p //パスは『example』
//nestjs_sample/db/initdb.d/sample.sqlのsqlうつ。
exit2回うってで出る。

$ docker exec -i -t app99 bash
$ cd ./nest-sample && npm run start:dev
```

## データリセットしたい時

```
$ make db_start
```

## nest プロジェクト作成まで

※以下はもう行っているため作業としては不要です。
※何か困った時の参考になるかと思い残しています。

```
必要なコンテナ作成
$ docker-compose up --build -d

# コンテナ内に入る
$ docker exec -i -t app99 bash

# プロジェクト作成コマンドうつ。※ここの時点で回答した物少し下に記載 ※ここでapp配下に『nest-sample』が作成されます。
$ nest new nest-sample


注意!! 以下は『nest new nest-sample』の時に回答した内容です。
? Which package manager would you ❤️  to use? (Use arrow keys)
❯ npm


$ cd nest-sample

# この時点で問題なく動くかの確認。※ここで『dist』作成される。
$ npm run start:dev

確認URL app
http://localhost:3001/


確認URL adminer
http://localhost:8085/

情報
サーバー: mysql99
ユーザー名: root
パスワード: example
データーベース: sample_db <=ここなくても可
```

## そのほかの共有事項

nest 既存から色々なもの追加の内容<br>
注意:不要なこと沢山してしまっていますが記録として残しておきたかったので残しています。

```
# コンテナ内に入る
$ docker exec -i -t app99 bash

# 右記載のもの入れる => https://github.com/typeorm/typeorm
$ npm install typeorm --save

$ npm install reflect-metadata --save

# mysqlドライバーインストール ※一回目うまく行っていなかったかも
$ npm install mysql --save

# 認証違うとのことでuninstall ※一回目うまく行っていなかったかも。色々やってみた
$ npm uninstall mysql
$ npm uninstall -D mysql
$ npm uninstall --save-dev mysql
$ npm uninstall -g mysql
$ npm uninstall mysql --save

# こっちでいけそうとのことで入れたがうまくいかず
$ npm install mysql2 --save

# mysql2の方変わらなかったので、dockerymlにコマンド追加してみた　けど　うまく行っていないようなのでまたはずし最初から

# nestにあったからこっちの方がよかったかも => 参考: https://docs.nestjs.com/recipes/sql-typeorm
$ npm uninstall mysql2 --save
$ npm install --save typeorm mysql2

# 以下をmain.tsファイルに追記
import "reflect-metadata";

//https://docs.nestjs.com/techniques/validation
$ npm i --save class-validator class-transformer
```

## ヒント (全体)

- ヒント 1

以下箇所OSのlocalhostに当てられているip出ないといけなさそう、macだと`127.0.0.1`でないこともあり。windowsはまだ確認出来ていない。
```
host: '192.168.3.35',
```

## ヒント (docker)

- ヒント 1

以下しないと上手くいきません(マウントしているフォルダ)。(makefile に入れています。`$ make app_start`通るようになってます。)

```
$ chmod -R 777 /path/to/path/nestjs_sample/db/mysql/logs
```

- ヒント 2 (きっと上記やっていれば以下あまり使うことなさそうです。)

再起動で治ったので以下が本当に必要かまだ不明です。
再起動前は以下で上手く行っていたので、、

```
docker logs　で　パーミッションエラー。
ログファイルの変更したら以下の以下のコマンドも打った方が良い？
うまくいかない時該当コンテナstop rmみたいにした方がいいかもです。
$ chmod -R 777 /path/to/path/nestjs_sample/db/mysql/logs

ボリューム新しいの使えていないよ系のワーニング。全てリセット
$ docker system prune --volumes
```

## そのほか

- `make start`以下行った状況で問題なく動く確認していますが、不足あるかもしれません。もしかしたら必要なのかもはコメントアウトで残しています。

```
$ docker stop <appコンテナID> <dbコンテナID> <adminerコンテナID>
$ docker rm <appコンテナID> <dbコンテナID> <adminerコンテナID>
$ docker system prune --volumes
$ docker image prune
```

- `docker stop`のみの場合はdb確認作業の時間は2,3回のみですが、全部削除からだと23回ほどかかります。