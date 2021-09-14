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
      expect(inre.find_by_id('12341234')).to eq(nil)
    end
  end

  describe '#find_all_by_customer_id' do
    it 'finds all instances matching the given customer id' do
      path = './data/invoices.csv'
      inre = InvoiceRepository.new(path)

      expect(inre.find_all_by_customer_id('5')).to be_an Array
      expect(inre.find_all_by_customer_id('5').first.merchant_id).to include('12336113')
      expect(inre.find_all_by_customer_id('5').length).to eq(8)
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'finds all instances matching the given merchant id' do
      path = './data/invoices.csv'
      inre = InvoiceRepository.new(path)

      expect(inre.find_all_by_merchant_id('12334912')).to be_an Array
      expect(inre.find_all_by_merchant_id('12334912').first.id).to include('17')
      expect(inre.find_all_by_merchant_id('12334912').length).to eq(15)
    end
  end
end
