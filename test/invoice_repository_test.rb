require_relative '../test/test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'


class InvoiceRepositoryTest < Minitest::Test

 def test_it_exists
   se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
   invoice = se.invoices.find_by_id(6)
   assert_instance_of InvoiceRepository, invoice
 end
end
