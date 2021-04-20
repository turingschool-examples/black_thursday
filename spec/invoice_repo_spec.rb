require 'CSV'
require 'sales_engine'

RSpec.describe InvoiceRepo do
  before(:each) do
    @sales_engine = SalesEngine.from_csv({:items => './data/items.csv',
                                          :merchants => './data/merchants.csv',
                                          :invoices => './data/invoices.csv',
                                          :invoice_items => './data/invoice_items.csv',
                                          :transactions  => './data/transactions.csv',
                                          :customers => './data/customers.csv'
                                        })
  end

  describe 'instantiation' do
    xit'::new' do
      invoice_repo = @sales_engine.invoices

      expect(invoice_repo).to be_an_instance_of(InvoiceRepo)
    end

    xit'has attributes' do
      invoice_repo = @sales_engine.invoices

      expect(invoice_repo.invoices).to be_an_instance_of(Array)
    end
  end

  describe '#methods' do
    xit'#all' do
      invoice_repo = @sales_engine.invoices

      expect(invoice_repo.all).to be_an_instance_of(Array)
    end

    xit'#create' do
      invoice_repo = @sales_engine.invoices
      invoice_info = {:id => 0,
                      :customer_id => 7,
                      :merchant_id => 8,
                      :status => 'pending',
                      :created_at => Time.now,
                      :updated_at => Time.now}

      expect(invoice_repo.create(invoice_info)).to be_an_instance_of(Invoice)
    end

    xit '#find by id' do
      item_repo = @sales_engine.items
      collection = item_repo.items
      item = item_repo.create({:id          => 1,
                               :name        => "Pencil",
                               :description => "You can use it to write things",
                               :unit_price  => 1099,
                               :created_at  => Time.now,
                               :updated_at  => Time.now,
                               :merchant_id => 2})

      #PASSING IN THE COLLECTION (NOT IDENTICAL TO SPEC)
      expect(item_repo.find_by_id(item.id, collection)).to eq(item)
      expect(item_repo.find_by_id(999999999, colleciton)).to eq(nil)
    end

    xit'#find all by customer id' do
      invoice_repo = @sales_engine.invoices
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

      expect(invoice_repo.find_all_by_customer_id(90000)).to eq([invoice_1, invoice_2])
      expect(invoice_repo.find_all_by_customer_id(7000000)).to eq([])
    end

    xit'#find all by merchant id' do
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

    xit'#find all by status' do
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

      expect(invoice_repo.find_all_by_status(:pending).length).to eq(1475)
      expect(invoice_repo.find_all_by_status(:processing)).to eq([])
    end

    xit'#update' do
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

    xit'#delete' do
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
