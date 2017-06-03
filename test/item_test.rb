require "minitest/autorun"
require "minitest/pride"
require "bigdecimal"
require_relative "../lib/item"
require_relative "../lib/sales_engine"
require_relative "../lib/item_repository"


class ItemTest < Minitest::Test
  attr_reader :item,
              :repo
  def setup
    small_csv_paths = {
                        :items     => "./test/data/small_item_set.csv",
                        :merchants => "./test/data/merchant_sample.csv",
                      }
    engine = SalesEngine.from_csv(small_csv_paths)
    csv  = CSV.open './test/data/small_item_set.csv', headers: true, header_converters: :symbol
    @repo = ItemRepository.new(csv, engine)

    @item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1099",
      :created_at  => "2016-01-11 11:30:35 UTC",
      :updated_at  => "1994-05-07 23:38:43 UTC",
      :merchant_id => "12334113"
      }, repo)
  end

  def test_it_exists
    assert_instance_of Item, item
  end

  def test_it_has_a_name
    assert_equal 'Pencil', item.name
  end

  def test_it_has_a_description
    assert_equal 'You can use it to write things', item.description
  end

  def test_it_has_a_unit_price
    assert_instance_of BigDecimal, item.unit_price
    assert_equal 10.99, item.unit_price
  end

  def test_it_knows_when_it_was_created_and_updated
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
  end

  def test_it_knows_merchant_id
    assert_equal 12334113, item.merchant_id
  end

  def test_it_can_convert_to_dollars
    assert_instance_of Float, item.unit_price_to_dollars
    assert_equal 10.99, item.unit_price_to_dollars
  end

  def test_it_can_have_other_values
    item2 = Item.new({
      name: "Eraser",
      description: "You can use it to erase things.",
      unit_price: 300,
      created_at: "2016-01-11 11:30:35 UTC",
      updated_at: "1994-05-07 23:38:43 UTC",
      merchant_id: "12341234"
      }, repo)

    assert_equal "Eraser", item2.name
    assert_equal "You can use it to erase things.", item2.description
    assert_equal 3.00, item2.unit_price
    assert_instance_of Time, item2.created_at
    assert_instance_of Time, item2.updated_at
    assert_equal 3.0, item2.unit_price_to_dollars
  end

  def test_it_knows_about_parent_repo
    assert_instance_of ItemRepository, item.repository
  end

  def test_it_can_get_its_merchant
    actual = item.merchant

    assert_instance_of Merchant, actual
    assert_equal 12334113, actual.id
  end
end
