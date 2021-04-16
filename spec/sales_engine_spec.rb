require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/item_repository'

RSpec.describe SalesEngine do
  before do
    @se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv'
    })
  end

  describe '#initialize' do
    it 'exists' do
   
      expect(@se).to be_instance_of(SalesEngine)
    end
    it 'creates an ItemRepository' do
    
      expect(@se.items).to be_instance_of(ItemRepository)
    end
    it 'creates an InvoiceRepository' do
     
      expect(@se.invoices).to be_instance_of(InvoiceRepository)
    end
  end
  
  describe '#invoice_percentage_by_status' do
    it 'shows percent of invoices by status' do
      
      expect(@se.invoice_percentage_by_status(:pending)).to eq(29.55)
      expect(@se.invoice_percentage_by_status(:shipped)).to eq(56.95)
      expect(@se.invoice_percentage_by_status(:returned)).to eq(13.5)
    end
  end
 
  describe '#find_merchant_by_id' do
    it 'returns a merchant_object when given a merchant_id' do
     
      expect(@se.find_merchant_by_id(12334105)).to be_a(Merchant)
    end
  end
  
  describe '#average_invoices_per_merchant' do
    it 'shows average invoices per merchant' do
     
      expect(@se.average_invoices_per_merchant).to eq(10.49)
    end
  end
  
  describe '#stdev_invoices_per_merchant' do
    it 'shows standard deviation of invoices per merchant' do
   
      expect(@se.stdev_invoices_per_merchant).to eq(3.29)
    end
  end
  
  describe '#top_merchants_by_invoice_count' do
    it 'shows top merchants by invoice count' do
   
      expect(@se.top_merchants_by_invoice_count.count).to eq(12)
      expect(@se.top_merchants_by_invoice_count.first).to be_a(Merchant)
    end
  end
  
  describe '#bottom_merchants_by_invoice_count' do
    it 'shows bottom merchants by invoice count' do
  
      expect(@se.bottom_merchants_by_invoice_count.count).to eq(4)
      expect(@se.bottom_merchants_by_invoice_count.first).to be_a(Merchant)
    end
  end
 
  describe '#top_days_by_invoice_count' do
    it 'shows top days by invoice count' do
  
      expect(@se.top_days_by_invoice_count).to eq(['Wednesday'])
    end
  end
end
