# 郵便番号 API

この郵便番号 API は GitHub ページを使用して静的なファイルで配信しているため信頼性が高く、さらにオープンソースなのでクライアントワークでも安心して使用できます。

また、郵便番号から英語の住所を取得することも可能です。（大口事業所個別番号は英語には対応していません。）

なお、この API は AWS の Lambda を使用して毎日更新しています。

## デモ

https://postal-code-api.otakumode.com/

## エンドポイント

```
https://postal-code-api.otakumode.com/api/v1/
```

## 使い方

郵便番号が`100-0014`(東京都千代田区永田町)の住所を取得したい場合。

https://postal-code-api.otakumode.com/api/v1/100/0014.json

```json
{
  "code": "1000014",
  "data": [
    {
      "prefcode": "13",
      "ja": {
        "prefecture": "東京都",
        "address1": "千代田区",
        "address2": "永田町",
        "address3": "",
        "address4": ""
      },
      "en": {
        "prefecture": "Tokyo",
        "address1": "Chiyoda-ku",
        "address2": "Nagatacho",
        "address3": "",
        "address4": ""
      }
    }
  ]
}
```

1 つの郵便番号に複数の住所がある場合は以下のような感じです。

https://madefor.github.io/postal-code-api/api/v1/618/0000.json

```json
{
  "code": "6180000",
  "data": [
    {
      "prefcode": "26",
      "ja": {
        "prefecture": "京都府",
        "address1": "乙訓郡大山崎町",
        "address2": "",
        "address3": "",
        "address4": ""
      },
      "en": {
        "prefecture": "Kyoto",
        "address1": "Oyamazaki-cho, Otokuni-gun",
        "address2": "",
        "address3": "",
        "address4": ""
      }
    },
    {
      "prefcode": "27",
      "ja": {
        "prefecture": "大阪府",
        "address1": "三島郡島本町",
        "address2": "",
        "address3": "",
        "address4": ""
      },
      "en": {
        "prefecture": "Osaka",
        "address1": "Shimamoto-cho, Mishima-gun",
        "address2": "",
        "address3": "",
        "address4": ""
      }
    }
  ]
}
```

大口事業所個別番号では英語の住所は空になっています。

https://madefor.github.io/postal-code-api/api/v1/100/8798.json

```json
{
  "code": "1008798",
  "data": [
    {
      "prefcode": "13",
      "ja": {
        "prefecture": "東京都",
        "address1": "千代田区",
        "address2": "霞が関",
        "address3": "１丁目３－２",
        "address4": "株式会社 ゆうちょ銀行"
      },
      "en": {
        "prefecture": "",
        "address1": "",
        "address2": "",
        "address3": "",
        "address4": ""
      }
    },
    {
      "prefcode": "13",
      "ja": {
        "prefecture": "東京都",
        "address1": "千代田区",
        "address2": "霞が関",
        "address3": "１丁目３－２",
        "address4": "株式会社 かんぽ生命"
      },
      "en": {
        "prefecture": "",
        "address1": "",
        "address2": "",
        "address3": "",
        "address4": ""
      }
    },
    {
      "prefcode": "13",
      "ja": {
        "prefecture": "東京都",
        "address1": "千代田区",
        "address2": "霞が関",
        "address3": "１丁目３－２",
        "address4": "日本郵政 株式会社"
      },
      "en": {
        "prefecture": "",
        "address1": "",
        "address2": "",
        "address3": "",
        "address4": ""
      }
    },
    {
      "prefcode": "13",
      "ja": {
        "prefecture": "東京都",
        "address1": "千代田区",
        "address2": "霞が関",
        "address3": "１丁目３－２",
        "address4": "日本郵便 株式会社 本社"
      },
      "en": {
        "prefecture": "",
        "address1": "",
        "address2": "",
        "address3": "",
        "address4": ""
      }
    }
  ]
}
```

## 仕様

- 大口事業所個別番号データは英語には対応していません。
- Gulp タスクで以下の処理を行っています。
  1. [日本郵便のウェブサイト](http://www.post.japanpost.jp/zipcode/)から[郵便番号データ](http://www.post.japanpost.jp/zipcode/dl/roman-zip.html)をダウンロード。
  2. ダウンロードしたファイルを解凍して、取り出した CSV をパース。
  3. 郵便番号の上 3 桁の名前を持つディレクトリを作り、その中に下 4 桁の名前を持つ JSON を作成。
- 上述の処理を Travis CI で実行し、その結果を gh-pages に push しています。
  - 郵便番号データの最後の行にある沖縄県八重山郡与那国町の JSON があるかどうかをチェックし、すべての JSON が生成されたものとしています。いいテスト方法があればぜひプルリクエストをお願いします。
- AWS の Lambda を使用して毎日更新しています。（[参考](https://github.com/miya0001/travis-builder-for-lambda)）

## ローカルで JSON データを作成する

このリポジトリを clone してください。

```
$ git clone git@github.com:tokyootakumode/postal-code-api.git
```

必要なモジュールをインストールしてください。

```
$ cd postal-code-api
$ npm install
```

以下のコマンドで API を生成してください。

```
$ npm run build
```

ローカルで API を動かしたい場合には以下のコマンドを実行してください。

```
$ npm start
```

## ローカルで docker で動作確認を行う

以下のコマンドを実行してください。

```
docker-compose up
```

キャッシュに問題が発生した場合、以下のコマンドを一度実行してください。

```
docker-compose build --no-cache
```

## 貢献

- バグレポートは[Issue](https://github.com/tokyootakumode/postal-code-api/issues)にお願いします。
- プルリクエストは大歓迎です。
- Star をつけてもらうと開発者たちのモチベーションが上がります。

## ライセンス

MIT
