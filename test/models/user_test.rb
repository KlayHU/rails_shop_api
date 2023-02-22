require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'valid: user with all valid things' do
    user = User.new(email:'user3@example.com', password_digest: 'admin', role: 1)
    assert user.valid?
  end

  test 'invalid: user with invalid email' do
    user = User.new(email: 'wrong_email', password_digest: '******', role: 2)
    assert_not user.valid?
  end

  test 'valid: user with valid password' do
    user = User::new(email: 'right@example.com', password_digest: '***', role:0)
    assert user.valid?
  end
end
