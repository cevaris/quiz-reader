class User < ActiveRecord::Base

	before_save :create_remember_token

	attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

	validates :password, presence: true, length: { minimum: 6 }, confirmation: true, if: :password_digest_changed?
  validates :name, presence: true, length: { maximum: 50 }


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  private

  def create_remember_token
    self.remember_token ||= SecureRandom.urlsafe_base64
    self.email = self.email.downcase
  end

end
