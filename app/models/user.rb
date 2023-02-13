class User < ApplicationRecord
    has_many :triggers

    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :user_name, presence: true, uniqueness: true
    validates :password,
              length: { minimum: 6 },
              if: -> { new_record? || !password.nil? }    
end
