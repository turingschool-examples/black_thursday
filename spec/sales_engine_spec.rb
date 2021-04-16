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
  describe '#invoice_percentage_by_status'

  def invoice_percentage_by_status(status)
    it 'shows percent of invoices by status' do
      expect(@se.invoice_percentage_by_status(:pending)).to eq(50.00)
      expect(@se.invoice_percentage_by_status(:shipped)).to eq(33.33)
      expect(@se.invoice_percentage_by_status(:returned)).to eq(16.67)
    end
  end
  # def find_merchant_by_id(merchant_id)
  #   @merchants.find_by_id(merchant_id)
  # end

  # def average_invoices_per_merchant
  #   @invoices.average_invoices_per_merchant
  # end

  # def stdev_invoices_per_merchant
  #   @invoices.stdev_invoices_per_merchant
  # end

  # def top_merchants_by_invoice_count
  #   @invoices.top_merchants_by_invoice_count
  # end

  # def bottom_merchants_by_invoice_count
  #   @invoices.bottom_merchants_by_invoice_count
  # end

  # def top_days_by_invoice_count
  #   @invoices.top_sales_days
  # end
end
