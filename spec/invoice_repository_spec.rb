require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require 'bigdecimal/util'

RSpec.describe InvoiceRepository do
  describe 'initialization' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv"
                              })
    invoice_repo = sales_engine.invoices

    it 'exists' do
      expect(invoice_repo).to eq(InvoiceRepository)
    end
  end



end
