require './lib/invoice_item'
require './lib/invoice_item_repository'

RSpec.describe 'invoice_item_repository' do
  describe '#initialize' do
    it 'is an instance of InvoiceItemRepository' do
      path = './data/invoice_items.csv'
      iir = InvoiceItemRepository.new(path)

      expect(iir).to be_an_instance_of InvoiceItemRepository
    end
  end

  describe 'all' do
    it 'returns an array of all invoice item instances' do
      path = './data/invoice_items.csv'
      iir = InvoiceItemRepository.new(path)

      expect(iir.all).to be_an Array
    end
  end

  describe 'find_by_id' do
    it 'returns an instance of InvoiceItem with matching id' do
      path = './data/invoice_items.csv'
      iir = InvoiceItemRepository.new(path)

      expect(iir.find_by_id("1")).to be_an_instance_of(InvoiceItem)
      expect(iir.find_by_id("1").id).to eq("1")
    end
  end
end
