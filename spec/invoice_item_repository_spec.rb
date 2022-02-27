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

    it 'find all by item id' do
      expect(@ii_repository.find_all_by_item_id(3)[0]).to be_a(InvoiceItem)
    end

    it 'find all invoice by invoice id' do
      expect(@ii_repository.find_all_by_invoice_id(10)[0]).to be_a(InvoiceItem)
    end

    it 'finds the current highest id' do
      expect(@ii_repository.current_highest_id).to eq(21830)
    end

    it 'create new invoice item' do
      @attributes = {
        :item_id => 11,
        :invoice_id => 12,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
        }
      @ii_repository.create(@attributes)
      expect(@ii_repository.find_by_id(21831)).to be_a(InvoiceItem)
    end

    it 'updates quanitity and unit price from invoice item' do
      original_time = @ii_repository.invoice_items.find_by_id(21831).updated_at
      attributes = {quanity: 10, unit_price: BigDecimal(1000000,7)}
      expect(@ii_repository.update(21831, attributes).updated_at).to be > original_time
    end
  end

end
