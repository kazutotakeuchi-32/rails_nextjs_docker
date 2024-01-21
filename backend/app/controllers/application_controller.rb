class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session

    def authenticate_user!
        set_token
        begin
          unless User.verfy_jwt(@token).present?
            return render json: { error: "認証エラー" }, status: :unauthorized
          end
        rescue JWT::DecodeError
          # JWT::DecodeErrorを別途取り扱う場合の処理
          return render json: { error: "JWTデコードエラー" }, status: :unauthorized
        rescue StandardError => e
          # その他のStandardErrorを取り扱う場合の処理
          return render json: { error: "認証エラー" }, status: :unauthorized
        end
    end

    def current_user
        set_token
        if request.headers["Authorization"].present?
            token = request.headers["Authorization"].split(" ")[1]
            User.find(JWT.decode(@token, Rails.application.secrets.secret_key_base)[0]["user_id"])
        else
            nil
        end
    end

    private

    def set_token 
        if request.headers["Authorization"].present?
            @token = request.headers["Authorization"].split(" ")[1]
        else
            nil
        end
    end

end
