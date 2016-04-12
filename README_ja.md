# ポートフォリオを作ろう！（API実装）
ポートフォリオに載せるプロジェクトの管理をするための Web API を実装しよう！

## 前提条件
このチャレンジは [GitHub](https://github.com) のアカウントと [Heroku](https://heroku.com) でサーバーが立っている事が前提となります。
始める前に GitHub で[アカウントを作成](https://github.com/join)し、 [Herokuでチャレンジ用のアプリケーションを作って](https://dashboard.heroku.com/new)ください。

## データベース
以下が今回のチャレンジで必要となるデータベースの情報です。
[database.sql](./specifications/database.sql)にファイルが提供されています。

```sql
-- SQLite3 のフォーマットで書かれています。
-- 使うデータベースによっては一部修正が必要な場合があります。
create table projects (
    id integer PRIMARY KEY AUTOINCREMENT,
    url varchar(255) NULL,
    title varchar(255) NOT NULL,
    description text NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
  );
```

## ステップ 1: account.json の記入
[account.json](./account.json)の `heroku_appname` の値に実装で使う Heroku のアプリケーション名を入力してください。（`App Name` の項目に入力した内容）  

```json
{
  "heroku_appname": "<App Name>"
}
```
`<App Name>` の部分を `<` と `>` も含めてアプリケーション名に修正してください。

## ステップ 2: テストを実行しつつ、サーバーを実装しよう！
実装が必要なエンドポイントは次の4つです。  
このAPIが満たすべき仕様の詳細については [api-first-spec](https://github.com/shunjikonishi/api-first-spec) によって表記されています。仕様が書かれたファイルへのリンクもあるので実際に確認してみてください。

- GET /api/projects
  - データの取得に成功した場合は `200 OK` を返すこと
  - [GET /api/projects spec](./specifications/localhost/GET-api-projects.spec.js)
- POST /api/projects
  - title と description のどちらかが空の場合は `400 BadRequest` を返すこと
  - データの生成に成功した場合は `200 OK` を返すこと
  - [POST /api/projects spec](./specifications/localhost/POST-api-projects.spec.js)
- GET /api/projects/:id
  - データの取得に成功した場合は `200 OK` を返すこと
  - データが取得できなかった場合は `404 NotFound` を返すこと
  - [GET /api/projects/:id spec](./specifications/localhost/GET-api-projects_id.spec.js)
- DELETE /api/projects/:id
  - データの削除に成功した場合は `200 OK` を返すこと
  - 削除するデータが取得できなかった場合は `404 NotFound` を返すこと
  - [GET /api/projects/:id spec](./specifications/localhost/DELETE-api-projects_id.spec.js)

### テストの実行  
次のコマンドをターミナル上で実行することでローカル環境でのテストが可能です。

```bash
$ npm install                               # モジュールのインストール (初回のみ実行)
$ $(npm bin)/mocha specifications/localhost  # ローカル環境でのテストの実行
```

実装前は下のように `failing` 状態のテストがあるので、全てのテストを `passing` の状態にできるようにサーバーを実装して下さい。

```
42 passing (16s)
6 failing
```
