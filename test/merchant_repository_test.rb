gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative "../lib/merchant_repository"
require_relative "../lib/sales_engine"

require 'csv'


class MerchantRepositoryTest < MiniTest::Test
  attr_reader :merchant_repository

  def setup
    @se = SalesEngine.from_csv({
                                 :items     => "./data/items.csv",
                                 :merchants => "./data/merchants.csv",
                                })
    @merchant_repository = MerchantRepository.new("./data/merchants.csv")
  end

  def test_merchant_maker_does_its_job
    assert_equal 12334112, merchant_repository.all[1].id
    assert_equal "Shopin1901", merchant_repository.all[0].name
  end

  def test_all_returns_all_the_merchant_instances
    assert_equal "Shopin1901", merchant_repository.all.first.name
    assert_equal "CJsDecor", merchant_repository.all.last.name
  end

  def test_find_by_id
    assert_equal "sparetimecrocheter",   merchant_repository.find_by_id(12335961).name
  end

  def test_find_by_id_invalid_returns_nil
    assert_equal nil, merchant_repository.find_by_id(0)
  end

  def test_it_finds_by_name
    assert_equal 12334112, merchant_repository.find_by_name("candisart").id
    assert_instance_of Merchant, merchant_repository.find_by_name("candisart")
  end

  def test_it_returns_with_invalid_name
    assert_equal nil, merchant_repository.find_by_name("idontexist")
  end

  def test_it_finds_all_by_name
    assert_equal 90, merchant_repository.find_all_by_name("AR").length
    assert_equal "LolaMarleys", merchant_repository.find_all_by_name("AR")[1].name
    assert_equal 1, merchant_repository.find_all_by_name("candis").length
    assert_equal "Candisart", merchant_repository.find_all_by_name("candis")[0].name
    assert_equal 90, merchant_repository.find_all_by_name("AR").length
  end

  def test_returns_empty_list_when_no_merchants_match_string
    assert_equal [], merchant_repository.find_all_by_name("idontexist")
  end

  def test_it_can_pull_items
    assert_instance_of Item, @se.merchants.find_items_by_merchant_id(12334141)[0]
  end
  def test_merchant_count
    assert_equal 475, @se.merchant_count
  end
end
