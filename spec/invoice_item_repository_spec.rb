require_relative '../lib/sales_engine'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_repository'
require 'bigdecimal/util'

RSpec.describe InvoiceItemRepository do
  describe 'initialization' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv",
                              :invoice_items => "./data/invoice_items.csv",
                              :customers => "./data/customers.csv"
                              })
    invoice_item_repo = sales_engine.invoice_items

    it 'exists' do
      expect(invoice_item_repo).to be_instance_of(InvoiceItemRepository)
    end

    it 'can create invoice item objects' do
      expect(invoice_item_repo.array_of_objects[0]).to be_instance_of(InvoiceItem)
    end
  end
end
