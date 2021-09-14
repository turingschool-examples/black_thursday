require 'rspec'
require './lib/invoice'
require './lib/invoice_repository'

describe InvoiceRepository do
  describe '#initialize' do
    it 'is an instance of InvoiceRepository' do
      path = './data/invoices.csv'
      inre = InvoiceRepository.new(path)

      expect(inre).to be_an_instance_of InvoiceRepository
    end
  end

  describe '#all' do
    it 'returns an array of all invoice instances' do
      path = './data/invoices.csv'
      inre = InvoiceRepository.new(path)

      expect(inre.all).to be_an Array
      expect(inre.all.first).to be_an_instance_of Invoice
      expect(inre.all.first.status).to eq("pending")
    end
  end

  describe '#find_by_id' do
    it 'finds an instance matching the given id' do
      path = './data/invoices.csv'
      inre = InvoiceRepository.new(path)

      expect(inre.find_by_id('379').merchant_id).to eq('12334434')
    end
  end
end
