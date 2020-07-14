module SessionsHelper
  # 渡されたユーザーでログインする
  # ユーザーのブラウザ内の一時cookiesに暗号化済みのユーザーIDが自動で作成するコード
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if session[:user_id]
      # 左辺が未定義または偽なら右辺の値を代入する
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
end
