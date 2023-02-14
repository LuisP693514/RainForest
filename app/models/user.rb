# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  validates :email, :session_token, 
    presence: true, 
    uniqueness: true
  validates :email, 
    length: {in: 3..255}, 
    format: {with: URI::MailTo::EMAIL_REGEXP }
  validates :name, 
    length: {in: 3..30},
    format: {without: URI::MailTo::EMAIL_REGEXP , message: '%{attribute} cannot be an email'},
    presence: true
  validates :password, 
    length: {in: 6..255}, allow_nil: true
  
  before_validation :ensure_session_token

  def self.find_by_credentials(u, p)
    user = self.find_by(email: u)

    user&.authenticate(p) ? user : nil
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  has_one :cart,
    foreign_key: :user_id,
    class_name: :Cart,
    dependent: :destroy


  has_many :cart_items,
    through: :cart,
    source: :cart_items

  private

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
  
end
