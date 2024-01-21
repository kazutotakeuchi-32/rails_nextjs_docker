class User < ApplicationRecord 
  has_many :likes, dependent: :destroy
  has_many :articles
  has_many :comments
  has_many :follows, dependent: :destroy, foreign_key: :user_id, class_name: "Follow"

  attr_accessor :password
  before_create :set_password_digest
  before_update :set_password_digest, if: :allow_password_change

  RESET_EXPIRED_AT = 1.hour

  JWT_EXPIRED_AT = 1.day

  def set_password_digest
    self.password_digest = BCrypt::Password.create(self.password)
  end

  def authenticate(password)
    BCrypt::Password.new(password_digest) == password && self.activated_at.present?
  end

  def create_jwt
    # トークンの作成
    current_time = Time.now.to_i
    payload = { user_id: self.id, exp: current_time  + User::JWT_EXPIRED_AT, iat: current_time }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.verfy_jwt(token)
    # トークンの検証
    payload, _ = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
    User.find(payload["user_id"]).present?
  end  

  def create_activation_digest
    activated_expired_at = Time.now + 1.day
    activation_digest = SecureRandom.urlsafe_base64
    update!(activation_digest: activation_digest, activated_expired_at: activated_expired_at)
  end

  def confrimed!
    update!(activated_at: Time.now, activated_expired_at: nil, activation_digest: nil)
  end

  def valid_confirmation_token?(token)
    activated_expired_at &&  activation_digest == token && activated_expired_at > Time.now
  end

  def confirmed?
    activated_at.present?
  end

  def create_reset_digest
    # トークンの作成
    self.reset_digest = SecureRandom.urlsafe_base64
    self.reset_sent_at = Time.now
    self.reset_expired_at = Time.now + self.class::RESET_EXPIRED_AT
    save!
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def send_confirmation_email
    UserMailer.confirm(self).deliver_now
  end

  def verfy_reset_token(token)
    # トークンの検証
    reset_digest == token && reset_expired_at > Time.now
  end



  def get_timeline 
    #  自分の記事とフォローしているユーザーの記事を取得
    #  記事に紐づくタグも取得
    #  誰がいつどの記事にいいねしたかも取得
    articles = Article.includes(:user,:user,article_tags: :tag ,likes: :user, comments: [:user, likes: :user])
    .where(user_id: [self.id] + self.follows.pluck(:user_id))
  end

end
