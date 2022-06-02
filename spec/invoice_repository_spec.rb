require './lib/invoice_repository'

RSpec.describe InvoiceRepository do
  before :each do
    @filepath = './data/invoices.csv'
    @collection = InvoiceRepository.new(@filepath)
    @attributes = {
      :customer_id => '1',
      :merchant_id => '12335938',
      :status => 'pending',
      :created_at => '2009-02-07',
      :updated_at => '2014-03-15'
    }
  end

  describe '#initialize' do
    it 'is an InvoiceRepository' do
      expect(@collection).to be_a InvoiceRepository
    end

    it 'can return an array of all known Invoice instances' do
      expect(@collection.all).to be_a Array
      expect(@collection.all.count).to eq 4985
      expect(@collection.all.first).to be_a Invoice
      expect(@collection.all.first.id).to eq '1'
    end
  end

  describe '#find_by_id' do
    it 'returns nil if no invoice has the searched id' do
      expect(@collection.find_by_id('2813308004')).to eq nil
    end

    it 'can return an invoice with a matching id' do
      expect(@collection.find_by_id('1')).to be_a Invoice
      expect(@collection.find_by_id('1').merchant_id).to eq '12335938'
    end
  end

  describe '#find_all_by_customer_id' do
    it 'returns an empty array if no invoices have matching customer id' do
      expect(@collection.find_all_by_customer_id('2813308004')).to eq []
    end

    it 'returns an array if invoices have matching customer id' do
      expect(@collection.find_all_by_customer_id('1').count).to eq 8
      expect(@collection.find_all_by_customer_id('3').count).to eq 3
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'returns an empty array if no invoices have matching merchant id' do
      expect(@collection.find_all_by_merchant_id('2813308004')).to eq []
    end

    it 'returns an array if invoices have matching merchant id' do
      expect(@collection.find_all_by_merchant_id('12335938').count).to eq 16
      expect(@collection.find_all_by_merchant_id('12335955').count).to eq 12
    end
  end

  describe '#find_all_by_status' do
    it 'returns an empty array if no invoices have matching status' do
      expect(@collection.find_all_by_status('in the void')).to eq []
    end

    it 'returns an array if invoices have matching status' do
      expect(@collection.find_all_by_status('pending').count).to eq 1473
      expect(@collection.find_all_by_status('shipped').count).to eq 2839
    end
  end

  describe '#create' do
    it 'can create a new Invoice with provided attributes' do
      expect(@collection.find_by_id('4986')).to eq nil
      @collection.create(@attributes)
      expect(@collection.find_by_id('4986')).to be_a Invoice
      expect(@collection.find_by_id('4986').customer_id).to eq '1'
      expect(@collection.find_by_id('4986').merchant_id).to eq '12335938'
      expect(@collection.find_by_id('4986').status).to eq 'pending'
      expect(@collection.find_by_id('4986').created_at).to eq '2009-02-07'
      expect(@collection.find_by_id('4986').updated_at).to eq '2014-03-15'
    end
  end

  describe '#update' do
    it 'can update the status of an invoice' do
      expect(@collection.find_by_id('1').status).to eq 'pending'
      @collection.update('1', 'shipped')
      expect(@collection.find_by_id('1').status).to eq 'shipped'
    end
  end

  describe '#delete' do
    it 'can delete an Invoice based on id' do
      expect(@collection.find_by_id('1').status).to eq 'pending'
      @collection.delete('1')
      expect(@collection.find_by_id('1')).to eq nil
    end
  end
end
