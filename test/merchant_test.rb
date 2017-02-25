require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'


class MerchantTest < Minitest::Test

  def test_it_creates_an_instance_of_merchant
    m = Merchant.new({:id => 12334105, :name => "Shopin1901"}, repo)
    assert m
  end

  def test_it_can_find_a_name
    file_hash = {
      items: './data/items.csv',
      merchants: './data/merchants.csv'
    }
    path = 'test/fixtures/merchant_sample_small.csv'
    se = SalesEngine.from_csv(file_hash)
    repo = Repository.new(se, path, Merchant)
    m = Merchant.new({:id => 12334105, :name => "Shopin1901"}, repo)

    assert_equal "Shopin1901", m.name
  end


  def test_it_can_find_an_id
    file_hash = {
      items: './data/items.csv',
      merchants: './data/merchants.csv'
    }
    path = 'test/fixtures/merchant_sample_small.csv'
    se = SalesEngine.from_csv(file_hash)
    repo = Repository.new(se, path, Merchant)
    m = Merchant.new({:id => 12334105, :name => "Shopin1901"}, repo)

    assert_equal 12334105, m.id
  end

end
