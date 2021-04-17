require 'CSV'
require './lib/sales_engine'
require './lib/merchant_repo'
require './lib/merchant'
require './lib/item'
require './lib/item_repo'

RSpec.describe ItemRepo do
  describe 'instantiation' do
    before(:each) do
      @repo = SalesEngine.from_csv({:items => "./data/items.csv",
                                    :merchants => "./data/merchants.csv"})
    end

    it '::new' do
      invoice_repo = InvoiceRepo.new('./data/invoices.csv', @repo)

      expect(invoice_repo).to be_an_instance_of(InvoiceRepo)
    end

    it 'has attributes' do
      invoice_repo = InvoiceRepo.new('./data/invoices.csv', @repo)

      expect(invoice_repo.invoices).to be_an_instance_of(Array)
    end
  end
end