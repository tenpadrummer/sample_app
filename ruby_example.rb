class Example
  # ユーザー名とメールアドレス (属性: attribute) に対応するアクセサー (accessor)
  # アクセサーを作成すると、そのデータを取り出すメソッド (getter) と、データに代入するメソッド (setter) をそれぞれ定義してくれる。
  # インスタンス変数@nameとインスタンス変数@emailにアクセスするためのメソッドが用意される
  attr_accessor :name, :email

  # initializeは、Rubyの特殊なメソッド
  # これは Example.newを実行すると自動的に呼び出されるメソッド
  # attributes変数は空のハッシュをデフォルトの値として持つため、名前やメールアドレスのないexampleを生成できる。
  def initialize(attributes = {})
    @name  = attributes[:name]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@name} <#{@email}>"
  end
end

# Rubyは文字列を扱うためのメソッドを多数持っている
# Rubyの世界では、すべてがオブジェクトである
# Rubyではdefというキーワードを使ってメソッドを定義する
# Rubyではclassというキーワードを使ってクラスを定義する
# Railsのビューでは、静的HTMLの他にERB (埋め込みRuby: Embedded RuBy) も使える
# Rubyの組み込みクラスには配列、範囲、ハッシュなどがある
# Rubyのブロックは (他の似た機能と比べ) 柔軟な機能で、添え字を使ったデータ構造よりも自然にイテレーションができる
# シンボルとはラベルである。追加的な構造を持たない (代入などができない) 文字列みたいなもの
# Rubyではクラスを継承できる
# Rubyでは組み込みクラスですら内部を見たり修正したりできる