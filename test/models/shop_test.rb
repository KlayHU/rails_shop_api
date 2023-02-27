require "test_helper"

class ShopTest < ActiveSupport::TestCase

  test 'valid: shop with all valid things' do
    shop = Shop.new(name: 'shopTest01', products_count: 0, order_count:1)
    shop.user = users(:four)
    assert shop.valid?
  end

  test 'invalid: shop with taken name' do
    shop =Shop.new(name: shops(:one).name, products_count: 0, order_count:2)
    shop.user = users(:five)
    assert_not shop.valid?
  end

  test 'invalid: shop with invalid user_id' do
    shop = Shop.new(name: 'shopTest02', products_count:0, order_count:1)
    shop.user = users(:two)
    assert_not shop.valid?
  end

  test 'invalid: shop with taken user_id' do
    shop = Shop.new(name: 'shopTest03', products_count:0, order_count:1)
    shop.user = shops(:one).user
    assert_not shop.valid?
  end

  test 'invalid: shop with invalid products_count' do
    shop = Shop.new(name:'shopTest04', products_count:0, order_count:1.50)
    shop.user = users(:six)
    assert_not shop.valid?
  end

end
