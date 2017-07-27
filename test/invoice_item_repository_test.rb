require_relative '../lib/invoice_item_repository'
require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/sales_engine'
require 'csv'
require 'bigdecimal'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
              :items => "./test/data/items_fixture.csv",
              :merchants => "./test/data/merchants_fixture.csv",
              :invoice_items => "./test/data/invoice_items_fixture.csv",
              :invoices => "./test/data/invoices_fixture.csv",
              :transactions => "./test/data/transactions_fixture.csv",
              :customers => "./test/data/customers_fixture.csv"
            })
    @iir = @se.invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_all_returns_all_known_invoice_item_instances
    assert_instance_of Array, @iir.all
    assert_equal 58, @iir.all.count
  end

  def test_find_by_id
    assert_instance_of InvoiceItem, @iir.find_by_id(1)
  end

end
