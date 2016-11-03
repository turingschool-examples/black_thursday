require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class MerchantTest < Minitest::Test
  attr_reader   :merchant

  def setup
    @merchant = Merchant.new({
      :id => 5,
      :name => "Turing School"
    })

  end

  def test_it_can_create_a_merchant
    assert merchant
  end

  def test_it_can_return_id
    assert_equal 5, merchant.id
  end

  def test_it_can_return_name
    assert_equal "Turing School", merchant.name
  end

  def test_that_a_merchant_knows_whose_its_parent_is
    mr = MerchantRepository.new("./fixture/merchant_test_file.csv")
    merchant = Merchant.new({}, mr)
    assert_equal mr, merchant.parent
  end

end
