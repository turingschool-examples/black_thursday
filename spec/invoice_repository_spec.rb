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

  describe '#find_all_by_merchant_id' do
    it 'can find all invoices by one merchant' do
      merchant_invoices = @ir.find_all_by_merchant_id("12334389")
      require 'pry'; binding.pry
      expect(merchant_invoices.class).to eq(Array)

      merchant_invoices = @ir.find_all_by_merchant_id("234568")
      expect(merchant_invoices).to eq([])
    end
  end

  describe '#find_all_by_status' do
    it 'can find all invoices with a specific status' do
      pending = @ir.find_all_by_status("pending")
      5.times do
        expect(pending.sample.status).to eq("pending")
      end
      expect(pending.class).to eq(Array)
    end
  end

  describe '#create' do
    it 'can created a new instance of Invoice' do
      invoice = @ir.create({:merchant_id => "12334389", :customer_id => "10", :status => "shipped"})
      highest_invoice_id = @ir.repository.sort_by {|invoice| invoice.id.to_i}.last

      expect(invoice).to be_an_instance_of(Invoice)
      expect(invoice.id > highest_invoice_id.id).to be true
    end
  end

  describe '#update' do
    it 'can update information on an invoice' do
      invoice = @ir.find_by_id("3")
      first_update = invoice.updated_at
      expect(invoice.status).to eq("shipped")
      @ir.update("3", "returned")
      expect(invoice.status).to eq("returned")
      expect(invoice.updated_at).not_to eq(first_update)
    end
  end

  describe '#delete' do
    it 'can remove an invoice from the repository' do
      invoice = @ir.repository.sample
      expect(@ir.repository.include?(invoice)).to be true
      @ir.delete(invoice.id)
      expect(@ir.repository.include?(invoice)).to be false
    end
  end
end
