class Api::V1::Auth::PasswordController < ApplicationController
  # リセットパスワードのメール送信
  # メールアドレスが存在する場合は、reset_digestを作成し、メールを送信する
  # メールアドレスが存在しない場合は、404を返す
  def create
   @user = User.find_by(email: params[:email])
    if @user.present? && @user.confirmed?
      @user.create_reset_digest
      @user.send_password_reset_email
    else 
      render json: { message: "メールアドレスが見つかりません" }, status: :not_found
    end
  end

  # パスワード再設定画面(リセットトークンの検証、リダイレクト)
  def edit 
    @user = User.find_by(reset_digest: params[:token])
    if @user.present? && @user.verfy_reset_token(params[:token])
      @user.allow_password_change = true
      @user.save!
      redirect_url = "http://localhost:8000/password/edit?token=#{params[:token]}"
      redirect_to redirect_url
    else
      render json: { message: "トークンが無効です" }, status: :not_found
    end
  end

  # パスワード再設定
  def update
    @user = User.find_by(reset_digest: params[:token])
    if @user.present? && @user.verfy_reset_token(params[:token])
      @user.update!(password: params[:password], reset_digest: nil, reset_expired_at: nil, reset_sent_at: nil)
      render json: { message: "パスワードを再設定しました" }
    else
      render json: { message: "トークンが無効です" }, status: :not_found
    end
  end

end
