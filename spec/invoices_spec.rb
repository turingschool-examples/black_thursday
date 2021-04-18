require 'rspec'
require 'bigdecimal'
require 'time'
require './lib/invoices'
require './lib/sales_engine'
require './lib/invoices_repo'

RSpec.describe Invoice do

  se = SalesEngine.from_csv({
  :invoices => "./data/invoices.csv",
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"
  })
  invoice_repo = se.invoices

  context 'it exists' do
    it 'exists' do
      expect(invoice_repo.invoice_list[0]).to be_instance_of(Invoice)
    end
  end
end
