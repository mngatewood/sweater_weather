require 'securerandom'

class User < ApplicationRecord

  has_many :favorites

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates_confirmation_of :password, allow_nil: true, allow_blank: false

end