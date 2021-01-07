require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant_repo'
require './lib/item_repo'
require './lib/item'
require './lib/merchant'
require 'mocha/minitest'

class ItemRepoTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"
                              })
    @ir   = @se.items
  end

  def test_create_an_item_repo_instance
    assert_instance_of ItemRepo, @ir
  end

  def test_can_return_all_items
    assert_equal @ir.item_list, @ir.all
  end

  def test_find_by_name
    item = @ir.find_by_name("Antique Rocking Horse")
    assert_equal "Antique Rocking Horse", item.name
  end

  def test_find_by_name_nil
    item = @ir.find_by_name(" ")
    assert_nil item
  end

  def test_find_all_with_description
    expected = @ir.find_all_by_description("Gorgeous hand knitted baby bootees")
    assert_equal "263399735", expected[0].id
  end

  def test_find_all_with_price
    expected = @ir.find_all_by_price(50000.0)
    assert_equal "263397919", expected[0].id
  end

  def test_all_by_price_range
    se = SalesEngine.from_csv({
                              :items     => "./data/items_sample.csv",
                              :merchants => "./data/merchants.csv"
                              })
    ir   = se.items

    expected = @ir.find_all_by_price(50000..500001)

    assert_equal "263397919", expected[0].id
    #(1..3)

    #find_all_by_price_in_range(range) - returns either []
    #or instances of Item where the supplied price is
     #in the supplied range
    #(a single Ruby range instance is passed in)
  end
end
