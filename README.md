# Ruby on Rails チュートリアルのサンプルアプリケーション

これは、次の教材で作られたサンプルアプリケーションです。   
[*Ruby on Rails チュートリアル*](https://railstutorial.jp/)
[Michael Hartl](http://www.michaelhartl.com/) 著

## ライセンス

[Ruby on Rails チュートリアル](https://railstutorial.jp/)内にある
ソースコードはMITライセンスとBeerwareライセンスのもとで公開されています。
詳細は [LICENSE.md](LICENSE.md) をご覧ください。

## 使い方

このアプリケーションを動かす場合は、まずはリポジトリを手元にクローンしてください。
その後、次のコマンドで必要になる RubyGems をインストールします。

```
$ bundle install --without production
```

その後、データベースへのマイグレーションを実行します。

```
$ rails db:migrate
```

最後に、テストを実行してうまく動いているかどうか確認してください。

```
$ rails test
```

テストが無事に通ったら、Railsサーバーを立ち上げる準備が整っているはずです。

```
$ rails server
```

詳しくは、[*Ruby on Rails チュートリアル*](https://railstutorial.jp/)
を参考にしてください。

# 注意点
- heroku-appの削除
```
# herokuappの一覧
heroku apps

# herokuappの削除
heroku apps:destroy -a=myproject
```

- 間違えた時の戻し方
```
rails generate controller StaticPages home help
rails destroy controller StaticPages home help

rails generate model User name:string email:string
rails destroy model User

rails db:migrate
rails db:rollback
# 一番最初に戻したい時
rails db:migrate VERSION=0
```

- stylesheets
`app/assets/stylesheets`のディレクトリの中に置かれたスタイルシートは`application.css`の一部としてwebサイトのレイアウトに読み込まれる。

# エラー
- `rails test`をするとなぜか`/Users/takumi-hiraoka/.rbenv/versions/3.0.2/lib/ruby/gems/3.0.0/gems/bootsnap-1.7.7/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:34:in 'require': cannot load such file -- rexml/document (LoadError)`というようなエラーが出る。  
このエラーがあったので、最後の方のguardfileの設定は行ってない。

- `<%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>`を`views/layout/application.html.erb`に入れるとエラーが出る
- `gem 'bootstrap', '~> 5.0.1'`だとエラーが出るので、教科書通り`gem bootstrap-sass`と書いた方が良い
- ユーザーコントローラーを作る際は、`rails generate controller Users new`を入力する
- `<% provide(:title, "Sign up")%>`は`provide`と`(:title)`の間の空白を開けてはいけない
-----------------  
### Section6
- `rails generate model User name:string email:string`を入力してUserモデルを生成
- `rails db:migrate`で実行
- `rails test:models`でモデルに関するテストだけを走らせることができる
- メールアドレスを定める正規表現 = `VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i`...[正規表現おすすめサイト](http://www.rubular.com/)  
------------------  
### Section7
- コントローラーの慣習である「リソース名は複数形」覚えておく
