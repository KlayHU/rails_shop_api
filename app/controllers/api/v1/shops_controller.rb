class Api::V1::ShopsController < ApplicationController

  before_action :set_shop, only: [:show]
  before_action :check_login, only: [:create]
  before_action :check_owner, only: [:update, :destroy]

  def index
    @shops = Shop.offset(@page).limit(@per_page)
    render json:{error_code:0, data:@shops, message:'OK'}, status:200
  end

  def show
    @data = set_response_data(@shop)
    render json: {error_code:0, data:@data, message:'OK'}, status:200
  end

  def create
    @user = current_user
    @shop = Shop.new(shop_params)
    @shop.user = @user
    @shop.transaction do
      @user.role = 2
      if @shop.save! && @user.save!
        @data = set_response_data(@shop)
        render json: {error_code:0, data:@data, message:'OK'}, status: 201
      end
    end
  end

  def update
    @user = current_user
    if @user.shop.update(shop_params)
      @data = set_response_data(@shop)
      render json: {error_code:0, data:@data, message:'OK'}, status:201
    else
      render json: {error_code:500, message:@shop.errors}, status:201
    end
  end

  def destroy
    @shop.destroy
    head 204
  end

  private
  def set_shop
    @shop = Shop.includes(:user).find_by_id params[:id]
    @shop = @shop || {}
  end

  def shop_params
    params.require(:shop).permit(:name, :products_count, :order_count)
  end

  def check_login
    head 401 unless current_user
  end

  def check_owner
    head 403 unless @shop&.user&.id == current_user&.id
  end

  public def set_response_data(shop)
    return {} unless shop.present?
    {
      id: shop.id,
      name: shop.name,
      products_count: shop.products_count,
      order_count: shop.order_count,
      created_at: shop.created_at,
      owner:{
        id: shop.user.id,
        email: shop.user.email
      }
    }
  end

end
