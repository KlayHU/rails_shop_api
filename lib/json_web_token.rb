class JsonWebToken

  SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

  def self.encode(payload, expire_time = 24.hours.from_now)
    payload[:expire_time] = expire_time.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY).first
    # 使针对hash指定访问使用的key允许使用字符串和符号
    HashWithIndifferentAccess.new decoded
  end

end