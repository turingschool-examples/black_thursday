require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/item_repository'

RSpec.describe SalesEngine do
  before do
    @se = SalesEngine.from_csv()
  end

  describe '#initialize' do
    it 'exists' do
        expect(@se).to be_instance_of(SalesEngine)
    end
    it 'creates an ItemRepository' do
        expect(@se.items).to be_instance_of(ItemRepository)
    end    
    it 'creates an InvoiceRepository' do
        expect(@se.invoices).to be_instance_of(InvoiceRepository)
    end
  end
end
