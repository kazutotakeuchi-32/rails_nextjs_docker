Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end


  namespace :api do
    namespace :v1 do
      namespace :auth do
        # 会員登録
        post '/', to: 'registrations#create'

        # 本人確認
        get '/confirm', to: 'confirmations#index'
        post '/confirm', to: 'confirmations#create'

        # ログイン
        post '/login', to: 'sessions#create'
        delete '/logout', to: 'sessions#destroy'

        # パスワードリセット
        post '/password', to: 'password#create'
        get '/password/edit', to: 'password#edit'
        patch '/password', to: 'password#update'
      end

      resources :users, only: [:index, :show, :update] do
        collection do
          get :me
        end
      end


      resources :posts 
      resources :articles do
        collection do
          get :timeline
        end
        resources :comments, only: [:index,:create, :destroy] do
          member do
            post :bad_like
            post :good_like
          end
        end
      end
    end
  end
end