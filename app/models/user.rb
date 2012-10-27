# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  college_id      :integer
#

class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation, :college_id
  has_secure_password

  belongs_to :college
  has_many :courses
  has_many :posts, dependent: :destroy

	before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

	validates :name, presence: true, length: { maximum: 20 },
                    uniqueness: { case_sensitive: false }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
