class User < ApplicationRecord
  # attr_accessorを使って「仮想の」属性を作成
  attr_accessor :remember_token
  # before_saveメソッドで、ユーザーをデータベースに保存する前にemail属性を強制的に小文字に変換
  before_save {self.email = email.downcase}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255}
  # メールアドレスの大文字小文字を無視した一意性の検証
  validates :email, format: {with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    # digestメソッド
    # costの値を決め、代入。secure_passwordのソースコードを参照。
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                              BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
    # 上のstringはハッシュ化する文字列、costはコストパラメータと呼ばれる値。コストパラメータはハッシュを算出するための計算コストを指定.
    # コストパラメータの値を高くすれば、ハッシュからオリジナルのパスワードを計算で推測することが困難になる。
  end

  # ランダムなトークンを返す
  # Ruby標準ライブラリのSecureRandomモジュールにあるurlsafe_base64メソッド
  # A–Z、a–z、0–9、"-"、"_"のいずれかの文字 (64種類) からなる長さ22のランダムな文字列を返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end