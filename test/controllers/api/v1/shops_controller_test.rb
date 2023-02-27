require "test_helper"

class Api::V1::ShopsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @shop = shops(:one)
    @user_5 = users(:five)
  end

  test 'index_success: should show shops' do
    get api_v1_shops_path, as: :as_json
    assert_response 200
  end

  test 'show_success: should show shop' do
    get api_v1_shop_path(@shop), as: :as_json
    json_response = JSON.parse(self.response.body)
    # 验证状态码
    assert_response 200
    # 验证返回数据
    assert_equal @shop.name, json_response['data']['name']
  end

  test 'create_forbidden: should not create shop without token' do
    post api_v1_shops_path,
         params: {shop:{name:'shop_name', products_count:10, order_count:10}},
         as: :as_json
    assert_response 401
  end

  test 'create_success: should create shop with token' do
    # 验证某个值变化了
    assert_difference('Shop.count', 1) do
      post api_v1_shops_path,
           headers: { Authorization: JsonWebToken.encode(user_id: @user_5.id) },
           params: {shop:{name:'shop_name', products_count:10, order_count:10 }},
           as: :as_json
    end
  end

end
