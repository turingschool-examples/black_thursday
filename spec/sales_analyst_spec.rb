require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/sales_analyst'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/item'
require './lib/merchant'

RSpec.describe SalesAnalyst do
  it 'exists' do
    se = SalesEngine.from_csv({
      items: './spec/truncated_data/items_truncated.csv',
      merchants: './spec/truncated_data/merchants_truncated.csv',
      invoices: './spec/truncated_data/invoices_truncated.csv'
    })
    sales_analyst = se.analyst
    expect(sales_analyst).to be_a(SalesAnalyst)
  end

  describe '#average_items_per_merchant' do
    it 'can find the average item per merchant' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv'
      })
      sales_analyst = se.analyst

      expect(sales_analyst.average_items_per_merchant).to eq(1.0)
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    it 'can find the average item per merchant standard deviation' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv'
      })
      sales_analyst = se.analyst

      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(0.82)
    end
  end

  describe '#merchants_with_high_item_count' do
    xit 'can find which merchants sell the most items' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv'
      })
      sales_analyst = se.analyst

      expect(sales_analyst.merchants_with_high_item_count).to eq([])
    end
  end
####Zach started here
  describe '#average_invoices_per_merchant' do
    it 'shows average number of invoices by merchant' do
      mock_sales_engine = instance_double('SalesEngine')
      sa = SalesAnalyst.new(mock_sales_engine)
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      allow(mock_sales_engine).to receive(:average_invoices_per_merchant){ir.average_invoices_per_merchant}
      expect(sa.average_invoices_per_merchant).to eq(10.49)
    end
  end
  describe '#average_invoices_per_merchant_standard_deviation' do
    it 'shows standard deviation of invoices by merchant' do
      mock_sales_engine = instance_double('SalesEngine')
      sa = SalesAnalyst.new(mock_sales_engine)
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      allow(mock_sales_engine).to receive(:stdev_invoices_per_merchant){ir.stdev_invoices_per_merchant}
      expect(sa.average_invoices_per_merchant_standard_deviation).to eq(3.29)
    end
  end
  describe '#top_merchants_by_invoice_count' do
    it 'tells which merchants are more than two standard deviations above the mean' do
      mock_sales_engine = instance_double('SalesEngine')
      mock_merchant_repo = instance_double('MerchantRepository')
      sa = SalesAnalyst.new(mock_sales_engine)
      merchant = Merchant.new({
                              id: '1',
                              name: 'Shopin1901',
                              created_at: '2010-12-10',
                              updated_at: '2011-12-04'
                              }, mock_merchant_repo)
      allow(mock_sales_engine).to receive(:find_merchant_by_id) {merchant}
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      allow(mock_sales_engine).to receive(:top_merchants_by_invoice_count){ir.top_merchants_by_invoice_count}
      expect(sa.top_merchants_by_invoice_count.count).to eq(12)
      expect(sa.top_merchants_by_invoice_count.first).to be_a(Merchant)
    end
  end

  describe '#bottom_merchants_by_invoice_count' do
    it 'tells which merchants are more than two standard deviations below the mean' do
      mock_sales_engine = instance_double('SalesEngine')
      mock_merchant_repo = instance_double('MerchantRepository')
      merchant = Merchant.new({
                              id: '1',
                              name: 'Shopin1901',
                              created_at: '2010-12-10',
                              updated_at: '2011-12-04'
                              }, mock_merchant_repo)
      allow(mock_sales_engine).to receive(:find_merchant_by_id) {merchant}
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      allow(mock_sales_engine).to receive(:bottom_merchants_by_invoice_count){ir.bottom_merchants_by_invoice_count}
      expect(ir.bottom_merchants_by_invoice_count.count).to eq(4)
      expect(ir.bottom_merchants_by_invoice_count.first).to be_a(Merchant)
    end
  end
end
