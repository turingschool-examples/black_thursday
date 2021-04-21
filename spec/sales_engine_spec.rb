require "CSV"
require "RSpec"
require "./lib/sales_engine"
require "./lib/item"
require "./lib/item_repo"
require "./lib/merchant_repo"
require "./lib/sales_analyst"

RSpec.describe SalesEngine do
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
    it 'exists' do
      sales_engine = @sales_engine


      expect(sales_engine).to be_an_instance_of(SalesEngine)
    end
    xit 'has attributes' do
      sales_engine = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})

      expect(sales_engine.items).to be_an_instance_of ItemRepo
      expect(sales_engine.merchants).to be_an_instance_of MerchantRepo
    end
  end

  describe 'methods' do
    it 'all_items' do
      sales_engine = @sales_engine

      expect(sales_engine.all_items).to be_a(Array)
    end

    it 'all_merchants' do
      sales_engine = @sales_engine

      expect(sales_engine.all_merchants).to be_a(Array)
    end

    it 'all_invoices' do
      sales_engine = @sales_engine

      expect(sales_engine.all_invoices).to be_a(Array)
    end

    # it 'item count' do
    #   sales_engine = @sales_engine

    #   expect(sales_engine.item_count).to be_a(Float)
    # end

    # it 'merchant count' do
    #   sales_engine = @sales_engine

    #   expect(sales_engine.merchant_count).to be_a(Float)
    # end

    it 'invoice count' do
      sales_engine = @sales_engine

      expect(sales_engine.invoice_count).to be_a(Float)
    end

    it 'average price' do
      sales_engine = @sales_engine

      expect(sales_engine.average_price).to be_a(Float)
    end

    it 'item count per merchant' do
      sales_engine = @sales_engine

      expect(sales_engine.item_count_per_merchant).to be_a(Hash)
    end

    it 'invoice count per day' do
      sales_engine = @sales_engine

      expect(sales_engine.invoice_count_per_day).to be_a(Hash)
    end

    it 'find all by merchant id' do
      sales_engine = @sales_engine

      expect(sales_engine.find_all_by_merchant_id(1)).to be_a(Array)
    end

    it 'find by id' do
      sales_engine = @sales_engine

      expect(sales_engine.find_by_id(1)).to be(nil)
    end

    it 'find all by status' do
      sales_engine = @sales_engine

      expect(sales_engine.find_all_by_status("success")).to be_a(Array)
    end

    it '#average items per merchant' do
      sales_engine = @sales_engine

      expect(sales_engine.average_items_per_merchant).to eq(2.88)
    end

    it '#average items per merchant standard deviation' do
      sales_engine = @sales_engine

      expect(sales_engine.average_item_price_standard_deviation).to eq(2899.93)
    end

    it '#merchants with high item count' do
      sales_engine = @sales_engine

      expect(sales_engine.merchants_with_high_item_count.first.class).to eq(Merchant)
    end

    it '#average average price per merchant' do
      sales_engine = @sales_engine

      expect(sales_analyst.average_average_price_per_merchant).to eq(350.29)
    end

    it '#invoice count' do
      sales_engine = @sales_engine

      expect(sales_engine.invoice_count).to eq(4985.0)
    end

    it '#average invoices per merchant' do
      sales_engine = @sales_engine

      expect(sales_engine.average_invoices_per_merchant).to eq(10.49)
    end

    it '#average invoices per merchant standard deviation' do
      sales_engine = @sales_engine

      expect(sales_engine.average_invoices_per_merchant_standard_deviation).to eq(3.29)
    end

    it '#top merchants by invoice count' do
      sales_engine = @sales_engine

      expect(sales_analyst.top_merchants_by_invoice_count.length).to eq(12)
    end
end
