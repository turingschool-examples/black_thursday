require './test/test_helper.rb'
require './lib/sales_engine.rb'
require 'pry'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv("content")
    assert_instance_of SalesEngine, se
  end

  def test_it_has_from_csv
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    assert_equal ({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      }), se.content
  end

  def test_merchants_creates_array_of_merchants
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    assert_equal 475, se.merchants.repository.count
  end

  def test_items_creates_repository_of_items
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    assert_instance_of ItemRepository, se.items
  end

  def test_it_can_create_a_new_entry
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    ir = se.items
    attributes = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    ir.create(attributes)
    sorted = ir.repository.sort_by { |item| item.id }
    assert_equal ir.find_by_id(263567475), sorted.last
    assert_equal ir.find_by_id(263567475).name, 'Pencil'
  end

end
