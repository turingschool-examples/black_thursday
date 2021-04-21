require 'CSV'
require 'sales_engine'

RSpec.describe InvoiceRepo do
  describe 'instantiation' do
    it'::new' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine) 

      expect(invoice_repo).to be_an_instance_of(InvoiceRepo)
    end

    it'has attributes' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine) 

      expect(invoice_repo.invoices).to be_an_instance_of(Array)
    end
  end

  describe '#methods' do
    it'#all' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine) 

      expect(invoice_repo.all).to be_an_instance_of(Array)
    end

    xit'#create' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine) 
      invoice_info = {:id => 0,
                      :customer_id => 7,
                      :merchant_id => 8,
                      :status => 'pending',
                      :created_at => Time.now,
                      :updated_at => Time.now}

      expect(invoice_repo.create(invoice_info)).to be_an_instance_of(Invoice)
    end

    xit'#find by id' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine) 
      collection = invoice_repo.invoices
      invoice = invoice_repo.create({:id => 0,
                                     :customer_id => 7,
                                     :merchant_id => 8,
                                     :status => 'shipped',
                                     :created_at => Time.now,
                                     :updated_at => Time.now})

      expect(invoice_repo.find_by_id(invoice.id)).to eq(invoice)
      expect(invoice_repo.find_by_id(999999999)).to eq(nil)
    end

    xit'#find all by customer id' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine) 
      collection = invoice_repo.invoices
      invoice_1 = invoice_repo.create({:id => 0,
                                       :customer_id => 90000,
                                       :merchant_id => 8,
                                       :status => 'pending',
                                       :created_at => Time.now,
                                       :updated_at => Time.now})

      invoice_2 = invoice_repo.create({:id => 0,
                                       :customer_id => 90000,
                                       :merchant_id => 8,
                                       :status => 'pending',
                                       :created_at => Time.now,
                                       :updated_at => Time.now})

      expect(invoice_repo.find_all_by_customer_id(90000, collection)).to eq([invoice_1, invoice_2])
      expect(invoice_repo.find_all_by_customer_id(7000000, collection)).to eq([])
    end

    xit'#find all by merchant id' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine) 
      collection = invoice_repo.invoices
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

      expect(invoice_repo.find_all_by_merchant_id(8, collection)).to eq([invoice_1, invoice_2])
      expect(invoice_repo.find_all_by_merchant_id(700000, collection)).to eq([])
    end

    xit'#find all by status' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine) 
      collection = invoice_repo.invoices
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

      expect(invoice_repo.find_all_by_status(:pending, collection).length).to eq(1475)
      expect(invoice_repo.find_all_by_status(:processing, collection)).to eq([])
    end

    it'#update' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine) 
      invoice = invoice_repo.create({:id => 0,
                                     :customer_id => 7,
                                     :merchant_id => 8,
                                     :status => 'pending',
                                     :created_at => Time.now,
                                     :updated_at => Time.now})

      invoice_repo.update(invoice.id, {:status => 'shipped'})

      expect(invoice.status).to eq('shipped')
      expect(invoice.updated_at).to be_an_instance_of(Time)
    end

    xit'#delete' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine) 
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

    it '#find all by day created' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine) 

      expect(invoice_repo.find_all_by_day_created("Saturday")).to be_a(Array)
    end

    xit '#invoice count per merchant' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine) 
      collection = invoice_repo.invoices

      expect(invoice_repo.invoice_count_per_merchant).to be_a(Hash)
    end

    xit '#invoice count per day' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine) 

      expect(invoice_repo.invoice_count_per_day).to be_a(Hash)
    end

    xit '#find all by date' do
      invoice_repo = @sales_engine.invoices
      date = Time.parse("2009-02-07")

      expect(invoice_repo.find_all_by_date(date)).to be_a(Array)
    end

    xit '#find_all_pending' do
      invoice_repo = @sales_engine.invoices

      expect(invoice_repo.find_all_pending).to be_a(Array)
    end

    it '#invoices by merchant' do
      invoice_repo = @sales_engine.invoices

      expect(invoice_repo.invoices_by_merchant).to be_a(Hash)
    end
  end
end
