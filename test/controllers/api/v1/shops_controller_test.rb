require "test_helper"

class Api::V1::ShopsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @shop = shops(:one)
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
end
