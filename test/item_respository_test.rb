require './test/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < MiniTest::Test

  def setup
    @items = ItemRepository.new('./data/items.csv')
  end

  def test_all_returns_array_of_item_intances
    assert_equal @items.items ,@items.all
  end

  def test_find_by_id_returns_instance_of_item
    assert_instance_of Item, @items.find_by_id(263395237)

    assert_equal "263395237", @items.find_by_id(263395237).id
  end

  def test_find_by_id_only_accepts_integers
    assert_raises ArgumentError do
      @items.find_by_id("a")
    end

    assert_raises ArgumentError do
      @items.find_by_id(["a", "b"])
    end
  end

  def test_find_by_name_returns_instance_of_item
    assert_instance_of Item, @items.find_by_name("510+ RealPush Icon Set")
  end

  def test_find_by_name_only_accepts_strings
    assert_raises ArgumentError do
      @items.find_by_name(1)
    end

    assert_raises ArgumentError do
      @items.find_by_name(["a", "b"])
    end
  end

  def test_find_all_with_desciption_returns_array_of_item_instances
    assert_instance_of Item, @items.find_all_with_description("socialmedia iconset!")[0]
  end

  def test_find_all_with_description_returns_empty_array_when_no_description
    assert_equal [], @items.find_all_with_description("pizza is whack!")
  end

  def test_find_all_by_price_returns_array_of_item_instances
    assert_instance_of Array, @items.find_all_by_price(12000)

    assert_instance_of Item, @items.find_all_by_price(12000)[0]
  end

  def test_find_all_by_price_only_accepts_fixnums
    assert_raises ArgumentError do
      @items.find_all_by_price('a')
    end

    assert_raises ArgumentError do
      @items.find_all_by_price(["a", "b"])
    end
  end

  def test_find_all_by_price_in_range_returns_array_of_item_instances
    assert_instance_of Array, @items.find_all_by_price_in_range((10..20))

    assert_instance_of Item, @items.find_all_by_price_in_range((10..20))[0]
  end

  def test_find_all_by_price_in_range_only_accepts_ranges
    assert_raises ArgumentError do
      @items.find_all_by_price_in_range(1)
    end

    assert_raises ArgumentError do
      @items.find_all_by_price_in_range(["a", "b"])
    end
  end

  def test_find_all_by_merchant_id_returns_an_array_of_item_instances
    assert_instance_of Array, @items.find_all_by_merchant_id("12334609")

    assert_instance_of Item, @items.find_all_by_merchant_id("12334609")[0]
  end

  def test_find_all_by_merchant_id_only_accepts_strings
    assert_raises ArgumentError do
      @items.find_all_by_merchant_id(1)
    end

    assert_raises ArgumentError do
      @items.find_all_by_merchant_id(["a", "b"])
    end
  end

end
