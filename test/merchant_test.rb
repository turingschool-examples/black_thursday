require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/merchant_repository'
require 'csv'
class MerchantTest < Minitest::Test
  def setup
    merchant_path = './data/merchants.csv'
    item_path = './data/items.csv'
    locations = { items: item_path,
                  merchants: merchant_path }
    @engine = SalesEngine.new(locations)
    @mr = MerchantRepository.new('./data/merchants.csv', @engine)
    @m = Merchant.new({ id: 5, name: 'Turing School' }, @mr)
  end
  def test_it_exists_and_has_attributes
    assert_instance_of Merchant, @m
    assert_equal 5, @m.id
    assert_equal 'Turing School', @m.name
    assert_instance_of MerchantRepository, @m.merchant_repo
  end
end
