class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  #validates :password, length: { minimum: 6 }

  after_initialize :ensure_session_token

  has_many :subs, foreign_key: :moderator_id

  def self.generate_random_token
    SecureRandom.base64
  end

  def self.find_by_credentials(username, password)
    user = self.find_by(username: username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_random_token
    self.save!
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_random_token
  end

end
