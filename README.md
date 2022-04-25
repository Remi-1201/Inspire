# Inspire
- 「Inspire」は、英語や日本語の名言を共有するための、
シャドーイングというメソッドに基づいた外国語の学習サポートアプリです。
- オリジナルアプリケーションであり、2022年4月28日に公開する予定です。
- https://inspire-myworld.com/ 
## 1. 開発環境
- Ruby 3.0.1
- Rails 6.0.3
## 2. 就業Termの技術
### 2.1 ユーザー管理機能
- Devise
- Oauth認証
- gem rails-admin
- gem cancancan
### 2.2 その他
- Ajaxを使ったコメント機能
- お気に入り機能
### 2.3 インフラー
- プラットフォーム: Heroku
- ストレージ: Amazon S3
- ドメイン: Amazon Route53
- SSL化: AMC, CloudFront
## 3. カリキュラム外の技術
- [Web Speech API](https://developer.mozilla.org/ja/docs/Web/API/Web_Speech_API)
- [MediaStream Recording API
](https://developer.mozilla.org/ja/docs/Web/API/MediaStream_Recording_API)
## 4. アプリケーションの実行手順
 ```
$ git clone git@github.com:Remi-1201/Inspire.git
$ cd Inspire
$ bundle install
$ rails db:create && rails db:migrate
$ rails s
 ```
## 5. カタログ設計
- [こちらのURLをご覧ください。](https://docs.google.com/spreadsheets/d/1GNTl4DNEhvb2DLouMBOnYZmqTYchVBeJzvau1kHosQY/edit#gid=1338661474)
## 6. テーブル定義書
- [こちらのURLをご覧ください。](https://docs.google.com/spreadsheets/d/1GNTl4DNEhvb2DLouMBOnYZmqTYchVBeJzvau1kHosQY/edit#gid=305853367)
## 7. ワイヤーフレーム
- [こちらのURLをご覧ください。](https://viewer.diagrams.net/?tags=%7B%7D&highlight=0000ff&edit=_blank&layers=1&nav=1&title=WireFrame#Uhttps%3A%2F%2Fdrive.google.com%2Fuc%3Fid%3D1cUUxcpzP1dtCMI-k7bq6wuyc1JHNxaus%26export%3Ddownload)
## 8. ER図
- [こちらのURLをご覧ください。](https://viewer.diagrams.net/?tags=%7B%7D&highlight=0000ff&edit=_blank&layers=1&nav=1&title=ER%20Original%20app#Uhttps%3A%2F%2Fdrive.google.com%2Fuc%3Fid%3D1aX4atW1n96IQXvBbuZ6wfXlapIzF23Xa%26export%3Ddownload)

![ER Original app drawio](https://user-images.githubusercontent.com/97021497/163712667-8da98d9a-dcf7-442c-9530-d3261cbe4e1f.png)

## 9. 画面遷移図
- [こちらのURLをご覧ください。](https://viewer.diagrams.net/?tags=%7B%7D&highlight=0000ff&edit=_blank&layers=1&nav=1&title=Screen%20transition.drawio#Uhttps%3A%2F%2Fdrive.google.com%2Fuc%3Fid%3D1QocrwVhzZFXcjohijY77hXFF1Rsk_I3t%26export%3Ddownload)

![Screen transition drawio (2)](https://user-images.githubusercontent.com/97021497/160573694-5f5267c6-3ec9-4d21-b757-2bb688752d4a.png)
