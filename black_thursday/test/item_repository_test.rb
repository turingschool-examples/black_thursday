require_relative 'test_helper'
require 'csv'
require_relative './../lib/item'
require_relative './../lib/item_repository'
require_relative './../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  #why do we have have attr_reader? could we use @ for everything? 
  attr_reader :repository,
              :engine

  def setup
    @engine = SalesEngine.from_csv(
      items: "./test/fixtures/truncated_items.csv",
      merchants: "./test/fixtures/truncated_merchants.csv"
    )

    @repository = ItemRepository.new("./test/fixtures/truncated_items.csv", engine)
  end

  def test_it_exists
    assert_instance_of ItemRepository, @repository
  end

  def test_returns_all_items_from_repository
    assert_equal 21, @repository.all.count
  end

  def test_it_can_find_by_id
    subject = repository.find_by_id(263420519)
    assert_instance_of Item, subject
    assert_equal "Custom Puppy Water Colors", subject.name
    assert_instance_of Time, subject.created_at
    #why do we have the above? 
  end

  def test_find_by_id_returns_nil_if_no_match_is_found
    assert_nil repository.find_by_id(987654321)
    assert_nil repository.find_by_id("smush mahn")
  end

  def test_find_test_by_name_find_matching_case_insensitive_name
    assert_equal Item, repository.find_by_name("ChRisTmas sweaters").class
    assert_equal "Christmas Sweaters", repository.find_by_name("ChRisTmas sweaters").name
    assert_instance_of Time, repository.find_by_name("ChRisTmas sweaters").created_at
  end

  def test_find_by_name_returns_nil_if_no_match_is_found
    assert_nil repository.find_by_name(["abc"])
    assert_nil repository.find_by_name("Rare Custom Puppies")
  end

  def test_find_all_by_description_returns_all_items_with_description_keyword
    expected = "Christmas mittens"
    actual = repository.find_all_with_description("Ugly")

    assert_equal Array, actual.class
    assert_equal Item, actual.first.class
    assert_equal "Christmas Socks", actual[1].name
    assert_equal expected, actual[-2].name
  end

  def test_test_all_returns_empty_array_if_no_match_is_found
    actual = repository.find_all_with_description("nothing!")

    assert_equal [], actual
    assert_equal [], repository.find_all_with_description(nil)
  end

  def test_find_all_by_price_returns_items_with_matching_price
    actual = repository.find_all_by_price(90)

    assert_equal 263414329, actual.first.id
    assert_equal 2, actual.length
  end

  def test_find_all_by_price_returns_empty_array_when_no_match_is_found
    actual = repository.find_all_by_price(9999)

    assert_equal [], actual
    assert_equal [], repository.find_all_by_price(nil)
  end

  def test_find_all_by_price_in_range
    actual = repository.find_all_by_price_in_range(90..100)

    assert_equal 3, actual.length
    assert_equal 263407925, actual.first.id
  end

  def test_find_all_by_price_in_range_returns_empty_array_when_no_match_is_found
    actual = repository.find_all_by_price_in_range(9999000..1901212480124)

    assert_equal [], actual
    assert_equal [], repository.find_all_by_price_in_range(nil)
  end

  def test_can_find_all_items_by_merchant_id
    actual = repository.find_all_by_merchant_id(12334185)

    assert_equal 6, actual.length
    assert_equal "Free standing glitter dogs", actual.first.name
  end

  def test_find_all_by_merchant_id_returns_empty_array_when_no_match_is_found
    actual = repository.find_all_by_merchant_id(123341853145111124)

    assert_equal [], actual
    assert_equal [], repository.find_all_by_merchant_id(nil)
  end

  def test_inspect_returns_rows_in_repository
    assert_equal "ItemRepository has 21 rows", repository.inspect
  end
end
