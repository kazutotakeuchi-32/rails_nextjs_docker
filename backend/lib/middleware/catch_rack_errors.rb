# @see https://github.com/waiting-for-dev/devise-jwt/issues/234
module Middleware
  class CatchRackErrors

    def initialize(app)
      @app = app
    end         # def initialize


    def call(env)

      begin
        @app.call(env)

      rescue JWT::DecodeError => e

        return [
          401, 
          { "Content-Type" => "application/json" },
          [ 
            { 
              message: '認証エラー',
              status: 401
            }.to_json 
          ]
        ]
      end     
        
    end         
  end          
end            