class User < ApplicationRecord
  # リレーション
  has_many :posts
  has_many :post_likes
  has_many :post_comments
  has_many :follows
  has_many :followers, foreign_key: :follow_user_id, class_name: "Follow"

  # データの保存前に、パスワードを暗号化するメソッド(convert_password)を実行するよう設定
  before_create :convert_password

  # パスワードを暗号化するインスタンスメソッド
  #   クラス名.クラスメソッド名（クラスからしか呼び出せない）
  def convert_password
    self.password = User.generate_password(password)
  end

  # パスワードをmd5に変換するselfでクラスメソッド
  def self.generate_password(password)
    # パスワードに適当な文字列を付加して暗号化する
    salt = 'h!hgamcRAdh38bajhvgai17ysvb'
    Digest::MD5.hexdigest(salt + password)
  end

  #   22-3
  # バリデーション
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  # ユーザーがフォローされているかどうかを判定
  def followed_by?(user)
    user.follows.exists?(follow_user_id: self.id)
  end



end
