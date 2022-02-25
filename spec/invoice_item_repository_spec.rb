require 'rspec'
require './lib/invoice_item_repository'

describe InvoiceItemRepository do
  se = SalesEngine.from_csv({:invoice_items => "./data/invoice_items.csv"})
  iir = se.invoice_items
  describe 'initialization' do
    it 'exists' do
      expect (iir).to be_a(InvoiceItemRepository)
    end
  end
end
