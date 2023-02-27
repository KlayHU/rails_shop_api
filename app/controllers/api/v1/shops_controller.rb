class Api::V1::ShopsController < ApplicationController

  before_action :set_per_page, only: [:index]
  before_action :set_page, only: [:index]

  def index
    @shops = Shop.offset(@page).limit(@per_page)
    render json:{error_code:0, data:@shops, message:'OK'}, status:200
  end

end
