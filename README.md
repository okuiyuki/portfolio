# Ss
単にポートフォリオとしてだけでなくユーザーにサービスとしての価値提供を考えて作成しました。<br>

## サイト概要
web系エンジニアを目指す初学者が自分の作品を披露でき、人の作品をみて自分のポートフォリオの参考にできるプラットフォーム

### 制作動機
1. 初学者の人がポートフォリオを作る際、参考にできるポートフォリオを見つけることが難しいと感じたため<br>
    1.1 Twitterでポートフォリオをなににしようか悩んでいる声がある<br>
    1.2 youtubeなどで「ポートフォリオに悩んでいる人」といった動画が存在する<br><br>

2. 自分のスキルを視覚化し、企業との接点を生み出すため

### 主な利用シーン
1. ポートフォリオをなににすれば良いか分からない時<br>
2. 自分の制作したポートフォリオをシェアしたい時

### 工夫した点
1. ユーザーが利用することを考えログインしなくても利用できる設計にしたこと<br><br>

2. 運用、保守のことも考えお問い合わせフォームを実装しユーザーからのフィードバックを受け取れるように設計したこと。<br><br>

3. ユーザーのストレスを減らすため検索がどのような条件でも可能な設計にした<br><br>


## 機能一覧
・新規登録、ログイン機能、ユーザー編集機能<br>
・ゲストユーザーログイン機能<br>
・ポートフォリオ投稿、一覧、削除、編集機能<br>
・ツイッターシェア機能(OGPの設定済み)<br>
・コメント投稿、削除機能<br>
・カテゴリ機能<br>
・フリーワード検索機能（同時にカテゴリの絞り込み可）<br>
・画像投稿機能（Active Storage)<br>
・いいね機能(いいねの降順で閲覧可)<br>
・通知機能(いいね、コメントに対して)<br>
・お問い合わせ送信機能（eメール）<br>

##ER図

![er-graph](https://user-images.githubusercontent.com/74046229/107149368-92486f00-699b-11eb-83e0-22916640a311.png)



### 使用技術
 Ruby 2.6.6<br>
 Rails 6.0.3.4<br>
 Mysql<br>
 JavaScript<br>
 jQuery<br>
 HTML,SCSS,Bootstrap
 Docker,DockerCompose<br>
 Git GitHub(project issue活用) <br>
 AWS(EC2,RDS,ALB,S3)<br>
 Nginx<br>
 Rspec<br>
 Puma<br>
 VScode<br>

