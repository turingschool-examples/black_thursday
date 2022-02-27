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
      @ii_repository = InvoiceItemRepository.new('./data/invoice_items.csv')
    end

    it 'exists' do
      expect(@ii_repository).to be_a(InvoiceItemRepository)
    end

    it 'returns CSV :: Table Object' do
      expect(@ii_repository.rows).to be_a(CSV::Table)
    end

    it 'returns all instances of invoice items' do
      expect(@ii_repository.all.count).to eq(21830)
      expect(@ii_repository.all[0]).to be_a(InvoiceItem)
    end

    it 'find invoice item by id' do
      expect(@ii_repository.find_by_id(2)).to be_a(InvoiceItem)
      expect(@ii_repository.find_by_id(2).id).to eq(2)
    end

  end

end
