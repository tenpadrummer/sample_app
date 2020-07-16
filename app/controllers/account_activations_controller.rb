class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    # 既に有効になっているユーザーを誤って再度有効化しないために必要なコード。
    # 正当であろうとなかろうと、有効化が行われるとユーザーはログイン状態になる。
    # このコードがないと、攻撃者がユーザーの有効化リンクを後から盗みだしてクリックするだけで、本当のユーザーとしてログインできてしまう。
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated,    true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
