require 'rspec'
require 'bigdecimal'
require 'time'
require './lib/sales_engine'
require './lib/items'
require './lib/items_repo'
require './lib/merchants'
require './lib/merchants_repo'
require './lib/invoices'
require './lib/invoices_repo'

RSpec.describe InvoiceRepo do

  se = SalesEngine.from_csv({
  :invoices => "./data/invoices.csv",
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"
  })
  invoice = se.invoices

  context 'it exists' do
    it 'exists' do
      expect(invoice).to be_instance_of(InvoiceRepo)
    end
  end
end
