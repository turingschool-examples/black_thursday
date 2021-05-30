require './lib/sales_analyst'
require 'bigdecimal'

RSpec.describe 'SalesAnalyst' do
  before(:all) do
    @se = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      transactions: './data/transactions.csv',
      invoice_items: './data/invoice_items.csv'
    )

    @sa = @se.analyst
  end

  describe '#initialize' do
    it 'creates an instance of SalesAnalyst' do

      expect(@sa).to be_an_instance_of(SalesAnalyst)
    end
    it 'is passed its engine' do

      expect(@sa.engine).to be_an_instance_of(SalesEngine)
    end
  end
  describe '#average_items_per_merchant' do
    it 'returns the average number of items all merchants sell' do

      expect(@sa.average_items_per_merchant).to eq(2.88)
    end
  end
  describe '#average_items_per_merchant_standard_deviation' do
    it 'returns the standard deviation of items per merchant' do

      expect(@sa.average_items_per_merchant_standard_deviation).to eq(3.26)
    end
  end

  describe '#merchants_with_high_item_count' do
    it 'returns all merchants more than one standard deviation on number of items' do

      expect(@sa.merchants_with_high_item_count[0].id).to eq(12334123)
    end
  end

  describe '#average_item_price_for_merchant' do
    it 'returns the average prices for the merchant identified by their id' do

      expect(@sa.average_item_price_for_merchant(12334159)).to eq(31.50)
    end
  end

  describe '#average_average_price_per_merchant' do
    it 'returns the average of all average prices' do

      expect(@sa.average_average_price_per_merchant).to eq(350.29)
    end
  end

  describe '#average_item_price' do
    it 'returns the average of the price of all items' do

      expect(@sa.average_item_price).to eq(BigDecimal(251.06, 10))
    end
  end
  describe '#item_price_standard_deviation' do
    it 'is evil witch magic' do

      expect(@sa.item_price_standard_deviation).to eq(2_900.99)
    end
  end

  describe '#golden_items' do
    it 'returns an array of all items more than 2 standard deviations from average' do

      expect(@sa.golden_items.length).to eq(5)
    end
  end

  describe '#average_invoices_per_merchant' do
    it 'shows the average number of invoices per merchant' do

      expect(@sa.average_invoices_per_merchant).to eq(10.49)
    end
  end

  describe '#average_invoices_per_merchant_standard_deviation' do
    it 'returns standard deviation of above ^^^' do

      expect(@sa.average_invoices_per_merchant_standard_deviation).to eq(3.29)
    end
  end

  describe '#invoices_per_merchant' do
    it 'returns invoices per each merchant id' do

      expect(@sa.invoices_per_merchant.length).to eq(@se.merchants.all.length)
    end
  end


  describe '#find_extreme_merchants' do
    it 'returns merchants more than two standard deviations above or below the mean' do

      expect(@sa.find_extreme_merchants(:+, :>)[0].name).to eq('jejum')
      expect(@sa.find_extreme_merchants(:-, :<)[0].name).to eq('WellnessNeelsen')
    end
  end

  describe '#top_merchants_by_invoice_count' do
    it 'returns merchants more than two standard deviations above the mean' do

      expect(@sa.top_merchants_by_invoice_count[0].name).to eq('jejum')
    end
  end

  describe '#bottom_merchants_by_invoice_count' do
    it 'returns merchants two standard deviations below the mean' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv'
      )

      @sa = se.analyst

      expect(@sa.bottom_merchants_by_invoice_count[0].name).to eq('WellnessNeelsen')
    end
  end

  describe '#invoices_per_day' do
    it 'returns the number of invocies per day' do

      expect(@sa.invoices_per_day.sum).to eq(@se.invoices.all.length)
    end
  end

  describe '#top_days_by_invoice_count' do
    it 'returns days one standard deviation above mean' do

      expect(@sa.top_days_by_invoice_count).to eq(['Wednesday'])
    end
  end

  describe '#invoice_status' do
    it 'returns the percentage of invoices in that state' do

      expect(@sa.invoice_status(:pending)).to eq(29.55)
      expect(@sa.invoice_status(:shipped)).to eq(56.95)
      expect(@sa.invoice_status(:returned)).to eq(13.5)
    end
  end

  describe '#standard_deviation' do
    it 'uses an array and average to calculate standard div' do

      expect(@sa.standard_deviation([1, 2, 3], 2)).to eq(1)
    end
  end

  describe '#invoice_paid_in_full' do
    it 'returns the successful transactions' do

      expect(@sa.invoice_paid_in_full?(2_179)).to eq(true)
      expect(@sa.invoice_paid_in_full?(2_179_390)).to eq(false)
    end
  end

  describe '#invoice_total' do
    it 'returns total of invoice' do

      expect(@sa.invoice_total(2_179)).to eq(31_075.11)
    end
  end

  describe '#invoice_paid_in_full' do
    it 'returns the successful transactions' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/transactions.csv'
      )

      sa = se.analyst

      expect(sa.invoice_paid_in_full?(2_179)).to eq(true)
      expect(sa.invoice_paid_in_full?(2_179_390)).to eq(false)
    end
  end

  describe '#invoice_total' do
    it 'returns total of invoice' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/transactions.csv',
        invoice_items: './data/invoice_items.csv'
      )

      sa = se.analyst

      expect(sa.invoice_total(2_179)).to eq(31_075.11)
    end
  end

  describe '#total_revenue_by_date' do
    it 'returns the total revenue for that date' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/transactions.csv',
        invoice_items: './data/invoice_items.csv'
      )

      sa = se.analyst
      date = Time.parse('2009-02-07')

      expect(sa.total_revenue_by_date(date)).to eq(21_067.77)
    end
  end

  describe '#top_revenue_earners' do
    it 'returns the top revenue earner' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/transactions.csv',
        invoice_items: './data/invoice_items.csv'
      )

      sa = se.analyst
      top_revenue_array = sa.top_revenue_earners(5)
      top_revenue_array_default = sa.top_revenue_earners

      expect(top_revenue_array.length).to eq(5)
      expect(top_revenue_array[0]).to be_an_instance_of(Merchant)
      expect(top_revenue_array_default.length).to eq(20)
      expect(top_revenue_array_default[0]).to be_an_instance_of(Merchant)
    end
  end

  describe '#merchants_with_pending_invoices' do
    it 'returns the merchants with pending invoices' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/transactions.csv',
        invoice_items: './data/invoice_items.csv'
      )

      sa = se.analyst

      expect(sa.merchants_with_pending_invoices.length).to eq(467)
    end
  end

  describe '#merchants_with_only_one_item' do
    it 'returns all merchants with only one item for sale' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/transactions.csv',
        invoice_items: './data/invoice_items.csv'
      )

      sa = se.analyst

      expect(sa.merchants_with_only_one_item.length).to eq(243)
    end
  end

  describe '#merchants_with_only_one_item_registered_in_month' do
    it 'returns all merchants with only one item for sale who were in month' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/transactions.csv',
        invoice_items: './data/invoice_items.csv'
      )

      sa = se.analyst

      expect(sa.merchants_with_only_one_item_registered_in_month('March').length).to eq(21)
    end
  end

  describe '#revenue_by_merchant' do
    it 'returns all revenue for that merchant' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/transactions.csv',
        invoice_items: './data/invoice_items.csv'
      )

      sa = se.analyst

      expect(sa.revenue_by_merchant(12334194)).to eq(BigDecimal(81572.4, 8))
    end
  end

  describe '#all_revenue_by_merchant' do
    it 'returns all revenue for that merchant' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/transactions.csv',
        invoice_items: './data/invoice_items.csv'
      )

      sa = se.analyst

      expect(sa.all_revenue_by_merchant.class).to eq(Array)
    end
  end
  describe '#most_sold_item_for_merchant' do
    it 'returns the item most sold for that merchant' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/transactions.csv',
        invoice_items: './data/invoice_items.csv'
      )

      sa = se.analyst

      expect(sa.most_sold_item_for_merchant(12334194).length).to eq(3)
    end
  end

  describe '#best_item_for_merchant' do
    it 'returns the item with the highest revenue for that merchant' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/transactions.csv',
        invoice_items: './data/invoice_items.csv'
      )

      sa = se.analyst

      expect(sa.best_item_for_merchant(12334194).name).to eq('Thukdokhin wax cord')
    end
  end

  describe '#items_sold_method' do
    it 'returns the number of an item sold linked to item_id' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/transactions.csv',
        invoice_items: './data/invoice_items.csv'
      )

      sa = se.analyst
      invoice_item_1 = InvoiceItem.new(cent_price: '42306', created_at: Time.now, id: '5397', invoice_id: '1214', item_id: '263523316', quantity: '6', repository: nil, updated_at: Time.now)

      expect(sa.items_sold_method([invoice_item_1])).to eq([[263523316, 6]])
    end
    it 'returns the revenue an item generated if revenue is passed true' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/transactions.csv',
        invoice_items: './data/invoice_items.csv'
      )

      sa = se.analyst
      invoice_item_1 = InvoiceItem.new(cent_price: '42306', created_at: Time.now, id: '5397', invoice_id: '1214', item_id: '263523316', quantity: '6', repository: nil, updated_at: Time.now)

      expect(sa.items_sold_method([invoice_item_1], true)).to eq([[263523316, 2538.36]])
    end
  end

  describe '#find_all_invoice_item_by_invoice_id' do
    it 'returns an array of all invoice_items linked to the passed invoice_id' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        transactions: './data/transactions.csv',
        invoice_items: './data/invoice_items.csv'
      )

      sa = se.analyst
      invoice_1 = Invoice.new({created_at: Time.now, customer_id: '35', id: '180', merchant_id: '12334194', repository: nil, status: 'pending', updated_at: Time.now})

      expect(sa.find_all_invoice_item_by_invoice_id([invoice_1]).length).to eq(4)
    end
  end
end
