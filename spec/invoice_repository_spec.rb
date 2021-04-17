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

  describe '#time_check' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              })
    item = sales_engine.items.all[0]

    it 'returns input as originally passed in if input is class Time' do
      time_object = Time.parse("2007-06-04 21:35:10 UTC")
      expect(item.time_check(time_object)).to eq(time_object)
    end

    it 'returns input converted to Time object if input is not class Time' do
      expect(item.time_check("2007-06-04 21:35:10 UTC")).to eq(Time.parse("2007-06-04 21:35:10 UTC"))
    end
  end
  
end
