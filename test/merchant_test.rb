require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class MerchantTest < Minitest::Test
  attr_reader   :merchant,
                :repository

  def setup
    @repository = MerchantRepository.new('./fixture/merchant_test_file.csv')
    @merchant = Merchant.new({
    :id => 5,
    :name => "Turing School"
    }, repository)
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

  def test_that_a_merchant_knows_who_its_parent_is
    assert_equal repository, merchant.parent
    assert_instance_of MerchantRepository, merchant.parent
  end

  def test_a_merchant_can_point_to_its_items
    sales_engine = SalesEngine.from_csv({
    :items => "./fixture/items.csv",
    :merchants => "./fixture/merchant_test_file.csv"
    })
    merchant = sales_engine.merchants.find_by_id(101)
    assert_equal 2, merchant.items.length
  end

  def test_a_merchant_can_point_to_its_invoices
    sales_engine = SalesEngine.from_csv({
    :merchants => "./fixture/merchant_test_file.csv",
    :invoices => "./fixture/invoices.csv"
    })
    merchant = sales_engine.merchants.find_by_id(101)
    assert_equal 1, merchant.invoices.length
  end

end
