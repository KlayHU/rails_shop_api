class Api::V1::TokensController < ApplicationController
  def create
    @user = User.find_by_email(token_params[:email])

    payload = {user_id: @user.id}
    expire_time = 24.hours.from_now
    if (JsonWebToken rescue nil)
      token = JsonWebToken.encode(payload, expire_time)
      render json: {error_code:0, data:{token:token, expire_time: expire_time}, message:'ok'},
             status: 201
    else
      head 401
    end
  end

  private
  def token_params
    params.require(:token).permit(:email, :password_digest)
  end

end
