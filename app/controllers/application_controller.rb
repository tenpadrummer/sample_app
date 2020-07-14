class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # Railsのセッション用ヘルパーを全コントローラで使用できるようにする
  include SessionsHelper

  def hello
    render html: "hello, world!"
  end
end
