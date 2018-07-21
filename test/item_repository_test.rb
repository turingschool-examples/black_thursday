require 'simplecov'
SimpleCov.start
require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test

  def setup
    @salesengine = SalesEngine.from_csv({items: './data/items.csv'})
    @item_repository = @salesengine.items
  end

  def test_it_exists
    ir = ItemRepository.new
    assert_instance_of ItemRepository, ir
  end

  def test_it_starts_with_no_items
    ir = ItemRepository.new
    assert_equal [], ir.all
  end

  def test_we_can_find_an_item_by_id
    id = 263395237
    result = @item_repository.find_by_id(263395237).id
    assert_equal id, result
  end

  def test_we_can_find_item_by_name
    name = "510+ RealPush Icon Set"
    result = @item_repository.find_by_name(name).name
    assert_equal name, result
  end

  def test_we_can_find_all_merchants_by_description
    item_1 = @item_repository.find_by_id(263397843)
    item_2 = @item_repository.find_by_id(263500896)
    item_3 = @item_repository.find_by_id(263501136)
    item_4 = @item_repository.find_by_id(263501436)
    item_5 = @item_repository.find_by_id(263501984)

    expected = [item_1, item_2, item_3, item_4, item_5]
    result = @item_repository.find_all_with_description("wood pen")

    assert_equal expected, result
  end

  def test_we_can_find_all_by_price
    item_1 = @item_repository.find_by_id(263410685)

    expected = [item_1]
    result = @item_repository.find_all_by_price(9999900)
    assert_equal expected, result
  end

  def test_we_can_find_all_by_price_in_range
    item_1 = @item_repository.find_by_id(263410685)
    expected = [item_1]
    result = @item_repository.find_all_by_price_in_range((9999895..9999905))
    assert_equal expected, result
  end

  def test_we_can_find_all_by_merchant_id
    item_1 = @item_repository.find_by_id(263410021)
    expected = [item_1]
    result = @item_repository.find_all_by_merchant_id(12334112)
    assert_equal expected, result
  end

  def test_we_can_create_an_item_instance_with_incremented_id
    item = @item_repository.create({name: "Patrick",
                                              description: "Male",
                                              unit_price: "100",
                                              created_at: "2017-01-01 00:00:00",
                                              updated_at: "2017-01-01 00:00:00",
                                              merchant_id: 12345678
                                            })
    expected = 263567475
    assert_equal expected, item.id
  end

end
