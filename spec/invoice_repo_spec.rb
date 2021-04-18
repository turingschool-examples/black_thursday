require 'CSV'
require './lib/sales_engine'
require './lib/invoice'
require './lib/invoice_repo'

RSpec.describe ItemRepo do
  before(:each) do
    @sales_engine = SalesEngine.from_csv({:items => './data/items.csv',
                                          :merchants => './data/merchants.csv',
                                          :invoices => './data/invoices.csv'})
  end
  
  describe 'instantiation' do
    it '::new' do
      invoice_repo = @sales_engine.invoices

      expect(invoice_repo).to be_an_instance_of(InvoiceRepo)
    end

    it 'has attributes' do
      invoice_repo = @sales_engine.invoices

      expect(invoice_repo.invoices).to be_an_instance_of(Array)
    end
  end

  describe '#methods' do
    it '#all' do
      invoice_repo = @sales_engine.invoices

      expect(invoice_repo.all).to be_an_instance_of(Array)
    end

    it '#create' do
      invoice_repo = @sales_engine.invoices
      invoice_info = {:id => 0,
                      :customer_id => 7,
                      :merchant_id => 8,
                      :status => 'pending',
                      :created_at => Time.now,
                      :updated_at => Time.now}

      expect(invoice_repo.create(invoice_info)).to be_an_instance_of(Invoice)
    end

    it '#find by id' do
      invoice_repo = @sales_engine.invoices
      invoice = invoice_repo.create({:id => 0,
                                     :customer_id => 7,
                                     :merchant_id => 8,
                                     :status => 'shipped',
                                     :created_at => Time.now,
                                     :updated_at => Time.now})
                                      
      expect(invoice_repo.find_by_id(invoice.id)).to eq(invoice)
      expect(invoice_repo.find_by_id(999999999)).to eq(nil)
    end

    it '#find all by customer id' do
      invoice_repo = @sales_engine.invoices
      invoice_1 = invoice_repo.create({:id => 0,
                                       :customer_id => 7,
                                       :merchant_id => 8,
                                       :status => 'pending',
                                       :created_at => Time.now,
                                       :updated_at => Time.now})

      invoice_2 = invoice_repo.create({:id => 0,
                                       :customer_id => 7,
                                       :merchant_id => 8,
                                       :status => 'pending',
                                       :created_at => Time.now,
                                       :updated_at => Time.now})

      expect(invoice_repo.find_all_by_customer_id(7)).to eq([invoice_1, invoice_2])
      expect(invoice_repo.find_all_by_customer_id(7000000)).to eq([])
    end

    it '#find all by merchant id' do
      invoice_repo = @sales_engine.invoices
      invoice_1 = invoice_repo.create({:id => 0,
                                       :customer_id => 7,
                                       :merchant_id => 8,
                                       :status => 'pending',
                                       :created_at => Time.now,
                                       :updated_at => Time.now})

      invoice_2 = invoice_repo.create({:id => 0,
                                       :customer_id => 7,
                                       :merchant_id => 8,
                                       :status => 'pending',
                                       :created_at => Time.now,
                                       :updated_at => Time.now})

      expect(invoice_repo.find_all_by_merchant_id(8)).to eq([invoice_1, invoice_2])
      expect(invoice_repo.find_all_by_merchant_id(700000)).to eq([])
    end

    it '#find all by status' do
      invoice_repo = @sales_engine.invoices
      invoice_1 = invoice_repo.create({:id => 0,
                                       :customer_id => 7,
                                       :merchant_id => 8,
                                       :status => 'pending',
                                       :created_at => Time.now,
                                       :updated_at => Time.now})

      invoice_2 = invoice_repo.create({:id => 0,
                                       :customer_id => 7,
                                       :merchant_id => 8,
                                       :status => 'pending',
                                       :created_at => Time.now,
                                       :updated_at => Time.now})
      
      invoice_3 = invoice_repo.create({:id => 0,
                                       :customer_id => 7,
                                       :merchant_id => 8,
                                       :status => 'shipped',
                                       :created_at => Time.now,
                                       :updated_at => Time.now})

      expect(invoice_repo.find_all_by_status('pending').length).to eq(1475)
      expect(invoice_repo.find_all_by_status('processing')).to eq([])
    end

    it '#update' do
      invoice_repo = @sales_engine.invoices
      invoice = invoice_repo.create({:id => 0,
                                     :customer_id => 7,
                                     :merchant_id => 8,
                                     :status => 'pending',
                                     :created_at => Time.now,
                                     :updated_at => Time.now})
      
      invoice_repo.update(invoice.id, {:status => 'shipped'})

      expect(invoice.status).to eq('shipped')
    end

    it '#delete' do
      invoice_repo = @sales_engine.invoices
      invoice = invoice_repo.create({:id => 0,
                                     :customer_id => 7,
                                     :merchant_id => 8,
                                     :status => 'pending',
                                     :created_at => Time.now,
                                     :updated_at => Time.now})
   
      expect(invoice_repo.all.length).to eq(4986)
  
      invoice_repo.delete(invoice.id)

      expect(invoice_repo.all.length).to eq(4985)
    end
  end
end
