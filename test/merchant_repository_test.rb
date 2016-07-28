gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative "../lib/merchant_repository"
require_relative "../lib/sales_engine"

require 'csv'


class MerchantRepositoryTest < MiniTest::Test
  def setup
    @merchant_repository = MerchantRepository.new("./data/merchants.csv")
  end

  def test_merchant_maker_does_its_job
    assert_equal 12334112, @merchant_repository.all[1].id
    assert_equal "Shopin1901", @merchant_repository.all[0].name
  end

   def test_all_returns_all_the_merchant_instances
     assert_equal "Shopin1901", @merchant_repository.all.first.name
     assert_equal "CJsDecor", @merchant_repository.all.last.name
   end

  def test_find_by_id
    assert_equal nil, @merchant_repository.find_by_id(0)
    assert_equal "sparetimecrocheter",   @merchant_repository.find_by_id(12335961).name
  end

  def test_it_finds_by_name
    assert_equal nil, @merchant_repository.find_by_name("idontexist")
    assert_equal 12334112, @merchant_repository.find_by_name("candisart").id
  end

  def test_it_finds_all_by_name
    assert_equal [], @merchant_repository.find_all_by_name("idontexist")
    assert_equal "Candisart", @merchant_repository.find_all_by_name("candis")[0].name
    assert_equal nil, @merchant_repository.find_all_by_name("candis")[1]
    assert_equal "LolaMarleys", @merchant_repository.find_all_by_name("AR")[1].name
    assert_equal 90, @merchant_repository.find_all_by_name("AR").length
  end



end
