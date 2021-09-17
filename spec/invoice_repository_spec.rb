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
      expect(inre.all.first.status).to eq(:pending)
    end
  end

  describe '#find_by_id' do
    it 'finds an instance matching the given id' do
      path = './data/invoices.csv'
      inre = InvoiceRepository.new(path)

      expect(inre.find_by_id(379).merchant_id).to eq(12334434)
      expect(inre.find_by_id(12341234)).to eq(nil)
    end
  end

  describe '#find_all_by_customer_id' do
    it 'finds all instances matching the given customer id' do
      path = './data/invoices.csv'
      inre = InvoiceRepository.new(path)

      expect(inre.find_all_by_customer_id(5)).to be_an Array
      expect(inre.find_all_by_customer_id(5).first.merchant_id).to eq(12336113)
      expect(inre.find_all_by_customer_id(5).length).to eq(8)
      expect(inre.find_all_by_customer_id(12341234)).to eq([])
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'finds all instances matching the given merchant id' do
      path = './data/invoices.csv'
      inre = InvoiceRepository.new(path)

      expect(inre.find_all_by_merchant_id(12334912)).to be_an Array
      expect(inre.find_all_by_merchant_id(12334912).first.id).to eq(17)
      expect(inre.find_all_by_merchant_id(12334912).length).to eq(15)
      expect(inre.find_all_by_merchant_id(12341234)).to eq([])
    end
  end

  describe '#find_all_by_status' do
    it 'finds all instances matching the given status' do
      path = './data/invoices.csv'
      inre = InvoiceRepository.new(path)

      expect(inre.find_all_by_status(:pending)).to be_an Array
      expect(inre.find_all_by_status(:pending).first.id).to eq(1)
      expect(inre.find_all_by_status(:pending).length).to eq(1473)
      expect(inre.find_all_by_status('this is not a status')).to eq([])
    end
  end

  describe '#create' do
    it 'creates a new Invoice instance' do
      path = './data/invoices.csv'
      inre = InvoiceRepository.new(path)

      attributes = ({
            :id          => 1,
            :customer_id => 7,
            :merchant_id => 8,
            :status      => 'pending',
            :created_at  => Time.now.round(2),
            :updated_at  => Time.now.round(2)
          })

      expect(inre.create(attributes).last).to be_an_instance_of Invoice
      expect(inre.create(attributes).last.id).to eq(4987)
      expect(inre.create(attributes).last.customer_id).to eq(7)
      expect(inre.create(attributes).last.status).to eq(:pending)
    end
  end

  describe '#update' do
    it 'updates an instance of Invoice' do
      path = './data/invoices.csv'
      inre = InvoiceRepository.new(path)

      attributes = ({
            :id          => 1,
            :customer_id => 7,
            :merchant_id => 8,
            :status      => 'shipped',
            :created_at  => Time.now.round(2),
            :updated_at  => Time.now.round(2),
          })

      inre.update(1, attributes)

      expect(inre.find_by_id(1).status).to eq(:shipped)
    end
  end

  describe '#delete' do
    it 'deletes an instance of Invoice' do
      path = './data/invoices.csv'
      inre = InvoiceRepository.new(path)

      inre.delete(1)

      expect(inre.find_by_id(1)).to eq(nil)
    end
  end
end
