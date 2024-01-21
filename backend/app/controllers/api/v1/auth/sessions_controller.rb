class Api::V1::Auth::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      return render json: {jwt: user.create_jwt}
    else
      return render json: {error: "メールアドレスかパスワードが間違っています"}, status: :unauthorized
    end

    rescue ActiveRecord::RecordNotFound
      render json: {error: "ユーザーが見つかりません"}, status: :not_found
  end

  def destroy
    render json: {jwt: nil} 
  end
end
