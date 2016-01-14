require 'minitest/autorun'
require 'minitest/pride'
require './lib/finder'

class FinderTest < Minitest::Test

include Finder

attr_reader :se

  def setup
    item_file = './data/test_items.csv'
    merch_file = './data/test_merchant.csv'
    invoice_file = './data/test_invoices.csv'
    @se = SalesEngine.from_csv({
          :items     => item_file,
          :merchants => merch_file,
          :invoices => invoice_file
            })
  end

  def test_finder_module_exists
    assert_equal Module, Finder.class
  end

  def test_find_by_id_returns_an_instance_of_merchant
    merchant = se.merchants.find_by_id(1)
    assert merchant.instance_of?(Merchant)
  end

  def test_find_by_id_returns_an_instance_of_item
    item = se.items.find_by_id(1)
    assert item.instance_of?(Item)
  end

end
