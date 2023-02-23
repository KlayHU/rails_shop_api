class User < ApplicationRecord

  # 使用dependent: :destroy -> 关联用户删除了，商铺也会被一起删除
  has_one :shop, dependent: :destroy

  # 增加字段校验
  validates :email, presence: true,
            uniqueness: true,
            format: { with: /\w+@\w+\.[a-zA-Z]{2,}/}
  validates :password_digest, presence: true
  validates :role, inclusion: { in: [0,1,2], message: "role can be only in [0,1,2]"}

end
