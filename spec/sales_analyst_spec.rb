require './lib/sales_analyst'
require './lib/sales_engine'
require './lib/item_repository'
require './lib/invoice_item_repository'
require './lib/customer_repository'

RSpec.describe SalesAnalyst do
  let(:sales_engine) {SalesEngine.from_csv({:items => './data/items.csv',
                                            :merchants => './data/merchants.csv',
                                            :invoices => './data/invoices.csv',
                                            :invoice_items => './data/invoice_items.csv',
                                            :customers => './data/customers.csv',
                                            :transactions => './data/transactions.csv'})}
  let(:sales_analyst) {sales_engine.analyst}

  xit 'exists' do
    expect(sales_analyst).to be_a SalesAnalyst
  end

  describe '#average_items_per_merchant' do
    xit 'gives how many items a merchant has on average' do
      expect(sales_analyst.average_items_per_merchant).to eq 2.88
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    xit 'returns the stdev of merchant average # of items' do
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

  describe '#average_item_price_for_merchant' do
    xit 'returns a BigDecimal of average item price' do
      expect(sales_analyst.average_item_price_for_merchant(12334105)).to eq 16.66
      expect(sales_analyst.average_item_price_for_merchant(12334257)).to eq BigDecimal(38.33,4)
    end
  end

  describe '#average_average_price_per_merchant' do
    xit 'returns the average of all merchant average prices' do
      expect(sales_analyst.average_average_price_per_merchant).to eq 350.29
    end
  end

  describe '#golden_items' do
    xit 'returns an array of all Item objects with price >2stdev above mean' do
      golden_items = sales_engine.items.find_all_by_price_in_range(6999..100000)
      expect(sales_analyst.golden_items).to eq golden_items
    end
  end

  describe '#average_item_price' do
    xit 'returns the average item price' do
      expect(sales_analyst.average_item_price).to eq 251.06
    end
  end

  describe '#average_invoices_per_merchant' do
    xit 'gives how many invoices a merchant has on average' do
      expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
    end
  end

  describe '#average_invoices_per_merchant_standard_deviation' do
    xit 'returns the stdev of merchant average # of invoices' do
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
    xit 'returns merchants whose average # of invoices <1 stdev' do
    avg = sales_analyst.average_invoices_per_merchant
    stdev = sales_analyst.average_invoices_per_merchant_standard_deviation
    expect(
      sales_analyst.bottom_merchants_by_invoice_count.all? {
      |merchant| sales_analyst.invoices.find_all_by_merchant_id(merchant.id).count < avg - (stdev * 2)
      }).to be true
    end
  end

  describe '#average_invoices_per_week_standard_deviation' do
    xit 'returns standard deviation of invoices per week' do

      expect(sales_analyst.average_invoices_per_week_standard_deviation).to eq 18.07
    end
  end

  describe '#invoice_days_count' do
    xit 'returns an array of invoice counts from sunday..saturday' do

      expect(sales_analyst.invoice_days_count).to eq [708, 696, 692, 741, 718, 701, 729]
    end
  end

  describe '#average_invoices_per_day' do
    xit 'returns the average invoices per day' do

      expect(sales_analyst.average_invoices_per_day).to eq 712.14
    end
  end

  describe '#invoice_week_sum_diff_square' do
    xit 'returns the first part of the formula for standard deviation' do

      expect(sales_analyst.invoice_week_sum_diff_square).to eq 1958.8572
    end
  end

  describe '#one_over_standard_dev' do
  xit 'returns the first part of the formula for standard deviation' do

    expect(sales_analyst.one_over_standard_dev).to eq 730.21
  end
end

  describe '#top_days_by_invoice_count' do
    xit 'return an array of the days at least one standard deviation over the mean' do

      expect(sales_analyst.top_days_by_invoice_count).to eq ["Wednesday"]
    end
  end

  # describe '#invoice_paid_in_full?(invoice_id)' do
  #   it 'return true if transaction success and false if failed' do

  #     expected = sales_analyst.invoice_paid_in_full?(1)
  #     expect(expected).to eq true

  #     expected = sales_analyst.invoice_paid_in_full?(200)
  #     expect(expected).to eq true

  #     expected = sales_analyst.invoice_paid_in_full?(203)
  #     expect(expected).to eq false

  #     expected = sales_analyst.invoice_paid_in_full?(204)
  #     expect(expected).to eq false
  #   end
  # end

  describe '#invoice_total(1)' do # changetest later to other invoice number
    it 'will return the invoice total for that id' do

      expect(sales_analyst.invoice_total(1)).to eq 21067.77
    end
  end

end