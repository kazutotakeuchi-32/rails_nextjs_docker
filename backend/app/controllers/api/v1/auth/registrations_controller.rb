class Api::V1::Auth::RegistrationsController < ApplicationController

  # ユーザー登録
  # ユーザー登録が成功した場合は、ユーザー情報を返し、認証メールを送信する
  def create 
    user = User.new(user_params)
    if user.save
      user.create_activation_digest
      UserMailer.confirm(user).deliver_now
      render json: user
    else
      render json: {error: user.errors.full_messages}
    end
  end

  private
  def user_params
    params.permit(:email, :password, :name)
  end
end
