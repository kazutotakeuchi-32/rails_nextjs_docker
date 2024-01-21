class Api::V1::Auth::ConfirmationsController < ApplicationController

  def index
    token = params[:token]

   return render json: { message: "トークンが無効です" }, status: :not_found  unless token.present?
    
    user = User.find_by(activation_digest: token)
    if user.present? && user.valid_confirmation_token?(token)
      user.confrimed!
      render json: { message: "認証が完了しました" }
    else
      render json: { message: "トークンが無効です" }, status: :not_found
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && !user.confirmed?
      user.create_activation_digest
      user.send_confirmation_email
      render json: { message: "認証メールを送信しました" }
    else
      render json: { message: "メールアドレスが見つかりません" }, status: :not_found
    end
  end

end
