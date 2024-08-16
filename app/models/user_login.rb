class UserLogin < ActiveRecord::Base
  belongs_to :loginable, polymorphic: true
  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :password_digest, presence: true, length: { maximum: 60 }
  
  has_secure_password
end