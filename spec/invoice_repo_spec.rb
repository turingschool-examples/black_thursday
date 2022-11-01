require './lib/invoice_repo'
require './lib/invoice'
require 'CSV'


describe InvoiceRepo do
  let(:data){CSV.readlines('./data/invoices_test.csv')}
  
  let(:ir) {InvoiceRepo.new(data)}

  describe '#initialize' do
    it 'exists' do      
      expect(ir).to be_a InvoiceRepo
    end
  end

  describe '#all' do
    it 'returns an array of all known Invoice instances' do
      expect(ir.all).to eq []
    end
  end

  describe '#find_by_id' do
    it 'returns either nil or an instance of Invoice with matching id' do
      ir.find_by_id(id).to eq ??
    end
  end

  describe '#find_by_customer_id' do
    it 'returns either [] or one or more instances of Invoice with matching customer id' do
      ir.find_by_customer_id(id).to eq ??
    end
  end

  describe '#find_by_merchant_id' do
    it 'returns either [] or one or more instances of Invoice with matching merchant id' do
      ir.find_by_merchant_id(id).to eq ??
    end
  end

  describe '#find_all_by_status' do
    it 'returns either [] or one or more instances of Invoice with matching status' do
      expect(ir.find_all_by_status(id)).to eq ??
    end
  end

  describe '#create' do
    it 'creates a new invoice instance with the provided attributes, new id is current highest + 1' do
      expect(ir.create(i_data)).to eq 
    end
  end

  describe '#update' do
    it 'updates the Invoice instance with the corresponding id with the provided attributes' do
      expect(ir.update(id, status)).to eq
    end
  end

  describe '#delete' do
    it 'deletes the Invoice instance with corresponding id' do
      ir.delete(id)
      expect(ir.invoices). to eq []
    end
  end
end