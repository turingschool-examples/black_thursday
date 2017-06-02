require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require './lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'


class MerchantTest < Minitest::Test

  attr_reader :merchant,
              :merchant2,
              :merchant3

  def setup
    small_csv_paths = {
                        :items     => "./test/data/small_item_set.csv",
                        :merchants => "./test/data/merchant_sample.csv",
                      }
    engine = SalesEngine.from_csv(small_csv_paths)
    csv  = CSV.open './test/data/merchant_sample.csv', headers: true, header_converters: :symbol
    repo = MerchantRepository.new(csv, engine)
    @merchant = Merchant.new({:id => 1, :name => "StarCityGames"}, repo)
    @merchant2 = Merchant.new({:id => 2, :name => "Amazong"},repo)
    @merchant3 = Merchant.new({:id => 12334213, :name => "Sal's Sassafras Supply"},repo)
  end

  def test_it_exists
    assert_instance_of Merchant, merchant
    assert_instance_of Merchant, merchant2
  end

  def test_it_has_id
    assert_equal 1, merchant.id
  end

  def test_it_has_a_name
    assert_equal "StarCityGames", merchant.name
  end

  def test_it_can_have_different_id
    assert_equal 2, merchant2.id
  end

  def test_it_can_have_different_name
    assert_equal "Amazong", merchant2.name
  end

  def test_it_knows_about_parent_repo
    assert_instance_of MerchantRepository, merchant.repository
    assert_instance_of MerchantRepository, merchant2.repository
  end

  def test_it_can_get_all_its_items
    actual = merchant3.items

    assert_instance_of Array, actual
    assert_instance_of Item, actual.sample
    assert_equal 2, actual.count
    assert_equal 12334213, actual.sample.merchant_id
  end
end
