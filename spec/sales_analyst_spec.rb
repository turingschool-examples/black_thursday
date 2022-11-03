require './lib/sales_analyst'
require './lib/sales_engine'
require './lib/item_repository'

RSpec.describe SalesAnalyst do
  let(:sales_engine) {SalesEngine.from_csv({:items => './data/items.csv',
                                  :merchants => './data/merchants.csv',
                                  :invoices => './data/invoices.csv'})}
  let(:sales_analyst) {sales_engine.analyst}

  it 'exists' do
    expect(sales_analyst).to be_a SalesAnalyst
  end

  describe '#average_items_per_merchant' do
    it 'gives how many items a merchant has on average' do
      expect(sales_analyst.average_items_per_merchant).to eq 2.88
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    it 'returns the stdev of merchant average # of items' do
      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq 3.26
    end
  end

  describe '#merchants_with_high_item_count' do
    xit 'returns merchants whose average # of items is >1 stdev' do
      avg = sales_analyst.average_items_per_merchant
      stdev = sales_analyst.average_items_per_merchant_standard_deviation

      expect(
        sales_analyst.merchants_with_high_item_count.all? {
          |merchant| sales_analyst.items.find_all_by_merchant_id(merchant.id).count > avg + stdev 
          }).to be true
    end
  end

  describe '#average_invoices_per_merchant' do
    it 'gives how many invoices a merchant has on average' do
      expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
    end
  end

  describe '#average_invoices_per_merchant_standard_deviation' do
    it 'returns the stdev of merchant average # of invoices' do
      expect(sales_analyst.average_invoices_per_merchant_standard_deviation). to eq 3.29
    end
  end

  describe '#top_merchants_by_invoice_count' do
    it 'returns merchants whose average # of invoices >2 stdev' do
    avg = sales_analyst.average_invoices_per_merchant
    stdev = sales_analyst.average_invoices_per_merchant_standard_deviation
    expect(
      sales_analyst.top_merchants_by_invoice_count.all? {
      |merchant| sales_analyst.invoices.find_all_by_merchant_id(merchant.id).count > avg + (stdev * 2)
      }).to be true
    end
  end

  describe '#bottom_merchants_by_invoice_count' do
    it 'returns merchants whose average # of invoices <1 stdev' do
    avg = sales_analyst.average_invoices_per_merchant
    stdev = sales_analyst.average_invoices_per_merchant_standard_deviation
    binding.pry
    expect(
      sales_analyst.bottom_merchants_by_invoice_count.all? {
      |merchant| sales_analyst.invoices.find_all_by_merchant_id(merchant.id).count > avg - (stdev * 2)
      }).to be true
    end
  end

  describe '#top_days_by_invoice_count' do
    it 'return an array or the top 2 days for invoices' do
      
    end
  end
end