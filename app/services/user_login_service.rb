class UserLoginService
  def list
    UserLogin.order('created_at DESC')
  end

  def auth(username, password)
    login = UserLogin.find_by(username: username)
    if login&.authenticate(password)
      generate_token(login)
    end
  end

  private

  def generate_token(login)
    token = SecureRandom.hex(10)
    login.update!(session_token: token)
    token
  end
end