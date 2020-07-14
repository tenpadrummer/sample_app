class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # has_secure_passwordが提供するauthenticateメソッド。ここで、authenticateメソッドは認証に失敗したときにfalseを返す。
    if user && user.authenticate(params[:session][:password])
      log_in user
      # if params[:session][:remember_me] == '1'
      # remember(user)
      # else
      # forget(user)
      # end を１行にまとめる三項演算子
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
