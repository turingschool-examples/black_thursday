require 'rspec'
require './lib/invoice_repository'

describe InvoiceRepository do
  describe '#initialize' do
    it 'is an instance of InvoiceRepository' do
      path = './data/items.csv'
      inre = ItemRepository.new(path)

      expect(inre).to be_an_instance_of ItemRepository
    end
  end
end
