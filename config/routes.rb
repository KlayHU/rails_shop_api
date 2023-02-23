Rails.application.routes.draw do
  resources :users

  # 设置请求参数格式为json
  namespace :api, defaults: { format: :json } do
    # 创建版本`v1`的命名空间，此时路由以'http://127.0.0.1:3000/api/v1'开头
    namespace :v1 do
      # 添加v1下controller相关方法的路由, only是限制当前只开放对这些方法的路由
      resources :users, only: [:index, :show, :create, :update, :destroy]
      post "/users/:id/update" => "users#update"
      post "/users/:id/destroy" => "users#destroy"
    end
  end
end
