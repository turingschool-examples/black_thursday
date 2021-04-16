require './lib/sales_analyst'

RSpec.describe 'SalesAnalyst' do
  before :all do
    se = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv'
    )
    sa = se.analyst
  end
  describe '#initialize' do
    it 'creates an instance of SalesAnalyst' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa).to be_an_instance_of(SalesAnalyst)
    end
    it 'is passed its engine' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.engine).to be_an_instance_of(SalesEngine)
    end
  end
  describe '#average_items_per_merchant' do
    it 'returns the average number of items all merchants sell' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.average_items_per_merchant).to eq(2.88)
    end
  end
  describe '#average_items_per_merchant_standard_deviation' do
    it 'returns the standard deviation of items per merchant' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.average_items_per_merchant_standard_deviation).to eq(3.26)
    end
  end
  describe '#merchants_with_high_item_count' do
    it 'returns all merchants more than one standard deviation on number of items' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.merchants_with_high_item_count[0].id).to eq(12334123)
    end
  end
  describe '#average_item_price_for_merchant' do
    it 'returns the average prices for the merchant identified by their id' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.average_item_price_for_merchant(12334159)).to eq(31.50)
    end
  end
  describe '#average_average_price_per_merchant' do
    it 'returns the average of all average prices' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.average_average_price_per_merchant).to eq(350.29)
    end
  end
  describe '#average_item_price' do
    it 'returns the average of the price of all items' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.average_item_price).to eq(BigDecimal(251.06, 10))
    end
  end
  describe '#item_price_standard_deviation' do
    it 'is evil witch magic' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.item_price_standard_deviation).to eq(2_900.99)
    end
  end
  describe '#golden_items' do
    it 'returns an array of all items more than 2 standard deviations from average' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.golden_items.length).to eq(5)
    end
  end

  describe '#average_invoices_per_merchant' do
    it 'shows the average number of invoices per merchant' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv'
      )
      sa = se.analyst

      expect(sa.average_invoices_per_merchant).to eq(10.49)
    end
  end

  describe '#average_invoices_per_merchant_standard_deviation' do
    it 'returns standard deviation of above ^^^' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv'
      )

      sa = se.analyst

      expect(sa.average_invoices_per_merchant_standard_deviation).to eq(3.29)
    end
  end

  describe '#invoices_per_merchant' do
    it 'returns invoices per each merchant id' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv'
      )

      sa = se.analyst

      expect(sa.invoices_per_merchant.length).to eq(se.merchants.all.length)
    end
  end

  describe '#top_merchants_by_invoice_count' do
    it 'returns merchants more tahn two standard deviations above the mean' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv'
      )

      sa = se.analyst

      expect(sa.top_merchants_by_invoice_count[0].name).to eq('jejum')
    end
  end

  describe '#bottom_merchants_by_invoice_count' do
    it 'returns merchants two standard deviations below the mean' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv'
      )

      sa = se.analyst

      expect(sa.bottom_merchants_by_invoice_count[0].name).to eq('WellnessNeelsen')
    end
  end

  describe '#invoices_per_day' do
    it 'returns the number of invocies per day' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv'
      )

      sa = se.analyst

      expect(sa.invoices_per_day.sum).to eq(se.invoices.all.length)
    end
  end

  describe '#top_days_by_invoice_count' do
    it 'returns days one standard deviation above mean' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv'
      )

      sa = se.analyst

      expect(sa.top_days_by_invoice_count).to eq(['Wednesday'])
    end
  end

  describe '#invoice_status' do
    it 'returns the percentage of invoices in that state' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv'
      )

      sa = se.analyst

      expect(sa.invoice_status(:pending)).to eq(29.55)
      expect(sa.invoice_status(:shipped)).to eq(56.95)
      expect(sa.invoice_status(:returned)).to eq(13.5)
    end
  end
end
