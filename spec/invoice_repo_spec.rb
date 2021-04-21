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

    it'#create' do
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

    it'#find by id' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine)
      collection = invoice_repo.invoices
      invoice = invoice_repo.create({:id => 0,
                                     :customer_id => 7,
                                     :merchant_id => 8,
                                     :status => 'shipped',
                                     :created_at => Time.now,
                                     :updated_at => Time.now})

      expect(invoice_repo.find_by_id(invoice.id, collection)).to eq(invoice)
      expect(invoice_repo.find_by_id(999999999, collection)).to eq(nil)
    end

    it'#find all by customer id' do
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

    it'#find all by merchant id' do
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

    it'#find all by status' do
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

      expect(invoice_repo.find_all_by_status(:pending, collection).length).to eq(8)
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

    it'#delete' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine)
      invoice = invoice_repo.create({:id => 0,
                                     :customer_id => 7,
                                     :merchant_id => 8,
                                     :status => 'pending',
                                     :created_at => Time.now,
                                     :updated_at => Time.now})

      expect(invoice_repo.all.length).to eq(11)

      invoice_repo.delete(invoice.id)

      expect(invoice_repo.all.length).to eq(10)
    end

    it '#find all by day created' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine)

      expect(invoice_repo.find_all_by_day_created("Saturday")).to be_a(Array)
    end

    it '#invoice count per merchant' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine)

      expect(invoice_repo.invoice_count_per_merchant).to be_a(Hash)
    end

    it '#invoice count per day' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine)

      expect(invoice_repo.invoice_count_per_day).to be_a(Hash)
    end

    it '#find all by date' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine)
      date = Time.parse("2009-02-07")

      expect(invoice_repo.find_all_by_date(date)).to be_a(Array)
    end

    it '#find_all_pending' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine)

      expect(invoice_repo.find_all_pending).to be_a(Array)
    end

    it '#invoices by merchant' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine)

      expect(invoice_repo.invoices_by_merchant).to be_a(Hash)
    end
  end

  describe '#salesanalyst' do
    it '#invoice count' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                            :merchants => './fixtures/mock_merchants.csv',
                                            :invoices => './fixtures/mock_invoices.csv',
                                            :invoice_items => './fixtures/mock_invoice_items.csv',
                                            :transactions  => './fixtures/mock_transactions.csv',
                                            :customers => './fixtures/mock_customers.csv'})

      invoice_repo = sales_engine.invoices

      expect(invoice_repo.invoice_count).to be_a(Float)
      expect(invoice_repo.invoice_count).to eq(10.0)
    end

    it '#invoice count per merchant' do
      mock_engine = double('InvoiceRepo')
      invoice_repo = InvoiceRepo.new('./fixtures/mock_invoices.csv', mock_engine)
      collection = invoice_repo.invoices

      expect(invoice_repo.invoice_count_per_merchant).to be_a(Hash)
    end

    it '#average invoices per merchant' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                           :merchants => './fixtures/mock_merchants.csv',
                                           :invoices => './fixtures/mock_invoices.csv',
                                           :invoice_items => './fixtures/mock_invoice_items.csv',
                                           :transactions  => './fixtures/mock_transactions.csv',
                                           :customers => './fixtures/mock_customers.csv'})

      invoice_repo = sales_engine.invoices

      expect(invoice_repo.average_invoices_per_merchant).to eq(1.11)
    end

    it '#average invoices per merchant standard deviation' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                           :merchants => './fixtures/mock_merchants.csv',
                                           :invoices => './fixtures/mock_invoices.csv',
                                           :invoice_items => './fixtures/mock_invoice_items.csv',
                                           :transactions  => './fixtures/mock_transactions.csv',
                                           :customers => './fixtures/mock_customers.csv'})

      invoice_repo = sales_engine.invoices

      expect(invoice_repo.average_invoices_per_merchant_standard_deviation).to eq(0.12)
    end

    it '#top_merchants_by_invoice_count' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                           :merchants => './fixtures/mock_merchants.csv',
                                           :invoices => './fixtures/mock_invoices.csv',
                                           :invoice_items => './fixtures/mock_invoice_items.csv',
                                           :transactions  => './fixtures/mock_transactions.csv',
                                           :customers => './fixtures/mock_customers.csv'})

      invoice_repo = sales_engine.invoices

      expect(invoice_repo.top_merchants_by_invoice_count.length).to eq(12)
    end

    it '#bottom_merchants_by_invoice_count' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                           :merchants => './fixtures/mock_merchants.csv',
                                           :invoices => './fixtures/mock_invoices.csv',
                                           :invoice_items => './fixtures/mock_invoice_items.csv',
                                           :transactions  => './fixtures/mock_transactions.csv',
                                           :customers => './fixtures/mock_customers.csv'})

      invoice_repo = sales_engine.invoices

      expect(invoice_repo.bottom_merchants_by_invoice_count.length).to eq(4)
    end

    it '#average_invoice_per_day_standard_deviation' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                           :merchants => './fixtures/mock_merchants.csv',
                                           :invoices => './fixtures/mock_invoices.csv',
                                           :invoice_items => './fixtures/mock_invoice_items.csv',
                                           :transactions  => './fixtures/mock_transactions.csv',
                                           :customers => './fixtures/mock_customers.csv'})

      invoice_repo = sales_engine.invoices      
 
      expect(invoice_repo.average_invoice_per_day_standard_deviation).to eq(1.13)
    end


    it '#top_days_by_invoice_count' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                           :merchants => './fixtures/mock_merchants.csv',
                                           :invoices => './fixtures/mock_invoices.csv',
                                           :invoice_items => './fixtures/mock_invoice_items.csv',
                                           :transactions  => './fixtures/mock_transactions.csv',
                                           :customers => './fixtures/mock_customers.csv'})

      invoice_repo = sales_engine.invoices      
 
      expect(invoice_repo.top_days_by_invoice_count.length).to eq 1
      expect(invoice_repo.top_days_by_invoice_count.first).to eq "Friday"
      expect(invoice_repo.top_days_by_invoice_count.first.class).to eq String
    end

    it '#invoice status' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                           :merchants => './fixtures/mock_merchants.csv',
                                           :invoices => './fixtures/mock_invoices.csv',
                                           :invoice_items => './fixtures/mock_invoice_items.csv',
                                           :transactions  => './fixtures/mock_transactions.csv',
                                           :customers => './fixtures/mock_customers.csv'})

      invoice_repo = sales_engine.invoices      

      expect(invoice_repo.invoice_status(:pending)).to eq 60.0
      expect(invoice_repo.invoice_status(:shipped)).to eq 56.95
      expect(invoice_repo.invoice_status(:returned)).to eq 13.5
    end
    
    it '#invoice total' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                           :merchants => './fixtures/mock_merchants.csv',
                                           :invoices => './fixtures/mock_invoices.csv',
                                           :invoice_items => './fixtures/mock_invoice_items.csv',
                                           :transactions  => './fixtures/mock_transactions.csv',
                                           :customers => './fixtures/mock_customers.csv'})

      invoice_repo = sales_engine.invoices

      expect(invoice_repo.invoice_total(1)).to eq(21067.77)
    end

    it '#total_revenue_by_date' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                           :merchants => './fixtures/mock_merchants.csv',
                                           :invoices => './fixtures/mock_invoices.csv',
                                           :invoice_items => './fixtures/mock_invoice_items.csv',
                                           :transactions  => './fixtures/mock_transactions.csv',
                                           :customers => './fixtures/mock_customers.csv'})

      invoice_repo = sales_engine.invoices
      date = Time.parse("2009-02-07")

      expect(invoice_repo.total_revenue_by_date(date)).to eq(21067.77)
    end

    it '#revenue_by_merchant_id' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                           :merchants => './fixtures/mock_merchants.csv',
                                           :invoices => './fixtures/mock_invoices.csv',
                                           :invoice_items => './fixtures/mock_invoice_items.csv',
                                           :transactions  => './fixtures/mock_transactions.csv',
                                           :customers => './fixtures/mock_customers.csv'})

      invoice_repo = sales_engine.invoices

      expect(invoice_repo.revenue_by_merchant_id).to be_a(Hash)
    end
  end
end
