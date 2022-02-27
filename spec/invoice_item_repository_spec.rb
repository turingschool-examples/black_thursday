require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'
require 'CSV'
require 'simplecov'
SimpleCov.start

RSpec.describe InvoiceItemRepository do

  describe 'create an invoice item' do

    before(:each) do
      @ii_repository = InvoiceItemRepository.new("./data/invoice_items.csv")
    end

    it 'exists' do
      expect(@ii_repository).to be_a(InvoiceItemRepository)
    end

  end

end
