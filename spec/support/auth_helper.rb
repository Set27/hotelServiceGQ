module AuthHelper
  def authenticated_context(user)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base.byteslice(0..31))
    token = crypt.encrypt_and_sign("user-id:#{ user.id }")
    { current_user: user, token: token }
  end
end