require "test_helper"

class Api::V1::ShopsControllerTest < ActionDispatch::IntegrationTest

  test 'index_success: should show shops' do
    get api_v1_shops_path, as: :as_json
    assert_response 200
  end

end
