require 'rspec'
require './lib/invoice_repository'

describe InvoiceRepository do
  before (:each) do
    @ir = InvoiceRepository.new('./data/invoices.csv')
  end

  describe '#initialize' do
    it 'exists' do
      expect(@ir).to be_an_instance_of(InvoiceRepository)
    end

    it 'creates a repository of Invoice items' do
      expect(@ir.repository.class).to eq(Array)
      5.times do
        expect(@ir.repository.sample.class).to eq(Invoice)
      end
    end
  end

  describe '#all' do
    it 'returns all instances of Invoice in the repository' do
      expect(@ir.all).to eq(@ir.repository)
    end
  end

  describe '#find_by_id' do
    it 'finds a specific invoice using the id' do
      invoice = @ir.find_by_id("214")

      expect(invoice.id).to eq("214")
      expect(invoice.class).to eq(Invoice)
    end
  end

  describe '#find_all_by_customer_id' do
    it 'can find all invoices by one customer' do
      customer_invoices = @ir.find_all_by_customer_id("9")
      expect(customer_invoices.class).to eq(Array)
    end
  end

end
