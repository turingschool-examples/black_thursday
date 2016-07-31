gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative "../lib/item_repository"
require_relative "../lib/sales_engine"
require 'csv'


class ItemRepositoryTest < MiniTest::Test
  attr_reader :item_repository

  def setup
    @se = SalesEngine.from_csv({
                                 :items     => "./data/items.csv",
                                 :merchants => "./data/merchants.csv",
                                })
    @item_repository = ItemRepository.new("./data/items.csv")
  end

  def test_it_maker_polulates_all_with_instances_of_item
    assert_instance_of Item, item_repository.all.first
    assert_equal 9, item_repository.all.length
  end

  def test_empty_id_returns_nil #sad test
    assert_equal nil, item_repository.find_by_id("not_a_valid_id")
    assert_equal nil, item_repository.find_by_id(666)
  end

  def test_it_finds_by_id
    assert_instance_of Item, item_repository.find_by_id(263395721)
    assert_equal "Disney scrabble frames", item_repository.find_by_id(263395721).name
  end

  def test_it_finds_by_name_invalid
    assert_equal nil, item_repository.find_by_name("not_a_valid_id")
    assert_equal nil, item_repository.find_by_name(666)
  end

  def test_it_finds_by_name
    assert_instance_of Item, item_repository.find_by_name("Disney scrabble frames")
    assert_equal 263395721, item_repository.find_by_name("Disney scrabble frames").id
  end

  def test_it_finds_all_with_description
    assert_equal [], item_repository.find_all_with_description("Mike Dao is HILARIOUS")
    assert_instance_of Item, item_repository.find_all_with_description("Disney glitter frames").first
    assert_equal 263395721, item_repository.find_all_with_description("Disney glitter frames").first.id
    assert_equal 2, item_repository.find_all_with_description("frames").length
  end

  def test_it_finds_by_price
    assert_equal [], item_repository.find_all_by_price(4895743895)
    assert_instance_of Item, item_repository.find_all_by_price(13.50).first
    assert_equal "Disney scrabble frames", item_repository.find_all_by_price(13.50).first.name
    assert_equal 2, item_repository.find_all_by_price(13.50).length
  end

  def test_it_returns_empty_array_when_it_find_nothing_in_a_price_range
    assert_equal  [], item_repository.find_all_by_price_in_range(1.00..4.00)
    assert_instance_of Item, item_repository.find_all_by_price_in_range(300..700).first
    assert_equal  1, item_repository.find_all_by_price_in_range(300.00..700.00).length
    assert_equal 1, item_repository.find_all_by_price_in_range(300..700).length
  end

  def test_it_finds_all_by_merchant_id_is_invalid
    assert_equal [], item_repository.find_all_by_merchant_id(38483)
  end

  def test_it_finds_all_by_merchant_id
    assert_instance_of Item, item_repository.find_all_by_merchant_id(12334185).first
    assert_equal 3, item_repository.find_all_by_merchant_id(12334185).length
    assert_equal "Glitter scrabble frames", item_repository.find_all_by_merchant_id(12334185).first.name
  end


    def test_it_can_tell_you_which_merchant_sells_it
      assert_instance_of Merchant, @se.items.find_by_id(263395237).merchant
    end
  def test_item_count
    assert_equal 9, @se.items.all.count
  end

end
