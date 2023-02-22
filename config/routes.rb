Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # user_controller.rb
  resources :users

  # 设置请求参数格式为json
  namespace :api, defaults: { format: :json } do
    # 创建版本`v1`的命名空间，此时路由以'http://127.0.0.1:3000/api/v1'开头
    namespace :v1 do

    end
  end
end
