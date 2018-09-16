require_relative 'test_helper'

require 'bigdecimal'

require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'


class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    path = {:invoice_items => './data/invoice_items.csv'}
    @repo = SalesEngine.from_csv(path).invoice_items
    # ===== Invoice Item Examples =================
    # id,item_id,invoice_id,quantity,unit_price,created_at,updated_at
    invoice_item_1_hash = { :"1" => { item_id:    "263519844",
                                      invoice_id: "1",
                                      quantity:   "5",
                                      unit_price: "13635",
                                      created_at: "2012-03-27 14:54:09 UTC",
                                      updated_at: "2012-03-27 14:54:09 UTC"
                                     } }
    @key = invoice_item_1_hash.keys.first
    @values = invoice_item_1_hash.values.first
    # @invoice_item_1 = InvoiceItem.new(@invoice_item_1_hash)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @repo
  end

  def test_it_gets_attributes
    # --- Read Only ---
    assert_instance_of Array, @repo.all
    assert_instance_of InvoiceItem, @repo.all[0]
    assert_equal @repo.all.count, @repo.all.uniq.count
    assert_equal 21830, @repo.all.count
  end

  def test_it_makes_invoice_items
    # This test is skipped because it will affect other tests.
    skip
    @repo.make_invoice_items
    assert_equal 21830 * 2, @repo.all.count
  end

  def test_it_makes_a_formatted_hash
    # -- The new hash needs an additional column --
    new_column = {:id => 1}
    new_hash = new_column.merge(@values.dup)
    assert_equal new_hash, @repo.make_hash(@key, @values)
  end


  # --- Find By ---

  def test_it_can_find_by_invoice_item_id
    assert_nil @repo.find_by_id(000)
    found = @repo.find_by_id(1)
    assert_instance_of InvoiceItem, found
    assert_equal 1, found.id
  end

  def test_it_can_find_all_invoice_items_by_item_id
    assert_equal [], @repo.find_all_by_item_id(000)
    found = @repo.find_all_by_item_id(263519844)
    assert_instance_of Array, found
    assert_instance_of InvoiceItem, found.first
    assert_equal 263519844, found.first.item_id
  end

  def test_it_can_find_all_invoice_items_by_invoice_id
    assert_equal [], @repo.find_all_by_invoice_id(000)
    found = @repo.find_all_by_invoice_id(1)
    assert_instance_of Array, found
    assert_instance_of InvoiceItem, found.first
    assert_equal 1, found.first.invoice_id
  end

end
