# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  realname        :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base


    attr_accessible :username, :realname, :email, :password, :password_confirmation
    has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :username, presence: true, length: { maximum: 30 }
  validates :realname, presence: true, length: { minimum: 2, maximum: 75 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 7 }, length:{ maximum: 40 }
  validates :password_confirmation, presence: true
  
  
    
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
    
    
end
