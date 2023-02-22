class User < ApplicationRecord
  # 增加字段校验
  validates :email, presence: true,
            uniqueness: true,
            format: { with: /\w+@\w+\.[a-zA-Z]{2,}/}
  validates :password_digest, presence: true
  validates :role, inclusion: { in: [0,1,2], message: "role can be only in [0,1,2]"}

  has_secure_password
end
