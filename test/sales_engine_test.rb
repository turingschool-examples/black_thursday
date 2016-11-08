require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items => "./fixtures/items_small_list.csv",
      :invoices => "./fixtures/invoices_small_list.csv",
      :merchants => "./fixtures/merchant_small_list.csv",
      :invoice_items => "./fixtures/invoice_item_small_list.csv",
      :transactions => "./fixtures/transactions_small_list.csv",
      :customers => "./fixtures/customers_small_list.csv"
    })
  end

  def test_it_exists
    refute @se.nil?
  end

  def test_sales_engine_can_load_csv_files
    assert_equal CSV::Table, @se.raw_data[:items].class
    assert_equal CSV::Table, @se.raw_data[:merchants].class
    assert_equal CSV::Table, @se.raw_data[:invoices].class
  end

  def test_it_can_talk_to_item_repo
    assert_equal Array, @se.items.all.class
  end

  def test_its_link_in_merchants_items_chain
    assert_equal "Vogue Paris Original Givenchy 2307", @se.find_all_items_by_merchant_id(12334105)[0].name
  end


end
