require "./test/test_helper"
require "./lib/item_repository"

class ItemRepositoryTest < MiniTest::Test

  def setup
    @items = ItemRepository.new("./test/fixtures/items_fixtures.csv")
  end

  def test_all_returns_array_of_item_intances
    assert_equal @items.items.values ,@items.all
  end

  def test_find_by_id_returns_instance_of_item
    assert_instance_of Item, @items.find_by_id(263423411)

    assert_equal 263423411, @items.find_by_id(263423411).id
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
    assert_instance_of Item, @items.find_by_name("Fluffy")
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
    assert_instance_of Item, @items.find_all_with_description(" pr")[0]
  end

  def test_find_all_with_description_returns_empty_array_when_no_description
    assert_equal [], @items.find_all_with_description("pizza is whack!")
  end

  def test_find_all_by_price_returns_array_of_item_instances
    assert_instance_of Array, @items.find_all_by_price(BigDecimal.new(1))

    assert_instance_of Item, @items.find_all_by_price(BigDecimal.new(1))[0]
  end

  def test_find_all_by_price_only_accepts_bigdecimal
    assert_raises ArgumentError do
      @items.find_all_by_price('a')
    end

    assert_raises ArgumentError do
      @items.find_all_by_price(["a", "b"])
    end
  end

  def test_find_all_by_price_in_range_returns_array_of_item_instances
    assert_instance_of Array, @items.find_all_by_price_in_range((100..400))

    assert_instance_of Item, @items.find_all_by_price_in_range((100..400))[0]
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
    assert_instance_of Array, @items.find_all_by_merchant_id(12335519)

    assert_instance_of Item, @items.find_all_by_merchant_id(12335519)[0]
  end

  def test_find_all_by_merchant_id_only_accepts_integers
    assert_raises ArgumentError do
      @items.find_all_by_merchant_id("d")
    end

    assert_raises ArgumentError do
      @items.find_all_by_merchant_id(["a", "b"])
    end
  end

end
