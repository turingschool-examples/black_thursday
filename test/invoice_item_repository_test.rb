require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_invoice_item_repository_exists
    iir = InvoiceItemRepository.new("./data/invoice_items.csv", self)

    assert_instance_of InvoiceItemRepository, iir
  end

  def test_invoice_item_repo_has_sales_engine_access
    se = SalesEngine.from_csv({
      :invoice_items => './data/invoice_items.csv'
      })
    iir = se.invoice_items

    assert_instance_of SalesEngine, iir.sales_engine
  end

end
