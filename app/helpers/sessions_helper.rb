module SessionsHelper
  # 渡されたユーザーでログインする
  # ユーザーのブラウザ内の一時cookiesに暗号化済みのユーザーIDが自動で作成するコード
  def log_in(user)
    session[:user_id] = user.id
  end
end
