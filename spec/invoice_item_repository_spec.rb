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
end 
