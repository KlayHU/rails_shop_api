class Api::V1::ShopsController < ApplicationController

  before_action :set_shop, only: [:show]

  def index
    @shops = Shop.offset(@page).limit(@per_page)
    render json:{error_code:0, data:@shops, message:'OK'}, status:200
  end

  def show
    @data = set_response_data(@shop)
    render json: {error_code:0, data:@data, message:'OK'}, status:200
  end

  private
  def set_shop
    @shop = Shop.includes(:user).find_by_id params[:id]
    @shop = @shop || {}
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
