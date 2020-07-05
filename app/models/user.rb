class User < ApplicationRecord
  # before_saveメソッドで、ユーザーをデータベースに保存する前にemail属性を強制的に小文字に変換
  before_save {self.email = email.downcase}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255}
  # メールアドレスの大文字小文字を無視した一意性の検証
  validates :email, format: {with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
end