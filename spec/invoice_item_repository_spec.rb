require './lib/invoice_item_repository'
require 'BigDecimal'
require 'CSV'


RSpec.describe InvoiceItemRepository do
  it 'exists' do
    invoice_items = './data/invoice_items.csv'
    ii_repo = InvoiceItemRepository.new(invoice_items)
    expect(ii_repo).to be_a(InvoiceItemRepository)
  end

  it 'returns an array of all known InvoiceItem instances' do
    invoice_items = './data/invoice_items.csv'
    ii_repo = InvoiceItemRepository.new(invoice_items)
    expect(ii_repo.all).to be_a(Array)
  end

    it 'return the amount of all known invoice_items instances' do
      invoice_items = './data/invoice_items.csv'
      ii_repo = InvoiceItemRepository.new(invoice_items)
      expect(ii_repo.all.count).to eq(21830)
    end

    it 'can find all by id' do
      invoice_items = './data/invoice_items.csv'
      ii_repo = InvoiceItemRepository.new(invoice_items)

      expect(ii_repo.find_by_id(1)).to be_an_instance_of(InvoiceItem)
      expect(ii_repo.find_by_id(999991)).to eq(nil)
    end


end
