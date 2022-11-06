require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/invoice'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require 'bigdecimal'

RSpec.describe SalesAnalyst do
  let(:se) {SalesEngine.from_csv({
    items: "./data/items.csv",
    merchants: "./data/merchants.csv",
    invoices: "./data/invoices.csv"
    })}

  it 'exists' do
    sales_analyst = SalesAnalyst.new(ItemRepository.new, MerchantRepository.new, InvoiceRepository.new)

    expect(sales_analyst).to be_a(SalesAnalyst)
  end

  describe '#analyst' do
    it 'creates an instance of SalesAnalyst' do
      expect(se.analyst).to be_a(SalesAnalyst)
    end
  end

  describe '#average_items_per_merchant' do
    it 'returns the an average amount of items a merchant sells' do
      sales_analyst = se.analyst

      expect(sales_analyst.average_items_per_merchant).to eq(2.88)

      sales_analyst.items.create({
        :name        => "Eraser",
        :description => "Erases pencil markings",
        :unit_price  => BigDecimal(2.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334159})

      sales_analyst.items.create({
        :name        => "Ball Point Pen",
        :description => "Makes permanent markings",
        :unit_price  => BigDecimal(3.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334159})

      sales_analyst.items.create({
        :name        => "Fountain Pen",
        :description => "Makes artisinal permanent markings",
        :unit_price  => BigDecimal(103.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334159})

      sales_analyst.items.create({
        :name        => "Mike Tyson's Ball Point Pen",
        :description => "Makes permanent markings",
        :unit_price  => BigDecimal(30_000.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334159})

      expect(sales_analyst.average_items_per_merchant).to eq(2.89)
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    it 'returns the standard deviation of the average items per merchant' do
      sales_analyst = se.analyst

      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)

      sales_analyst.items.create({
        :name        => "Eraser",
        :description => "Erases pencil markings",
        :unit_price  => BigDecimal(2.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334159})

      sales_analyst.items.create({
        :name        => "Ball Point Pen",
        :description => "Makes permanent markings",
        :unit_price  => BigDecimal(3.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334159})

      sales_analyst.items.create({
        :name        => "Fountain Pen",
        :description => "Makes artisinal permanent markings",
        :unit_price  => BigDecimal(103.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334159})

      sales_analyst.items.create({
        :name        => "Mike Tyson's Ball Point Pen",
        :description => "Makes permanent markings",
        :unit_price  => BigDecimal(30_000.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334159})

      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.28)
    end
  end

  describe '#array_of_items_per_merchant' do
    it 'returns an array of number of items for each merchant' do
      sales_analyst = se.analyst

      expect(sales_analyst.array_of_items_per_merchant.size).to eq(475)
      expect(sales_analyst.array_of_items_per_merchant.first).to eq(3)

      sales_analyst.merchants.create({ name: 'Whole Foods' })

      expect(sales_analyst.array_of_items_per_merchant.size).to eq(476)
    end
  end

  describe '#merchants_with_high_item_count' do
    it 'returns merchants who are more than one standard deviation above average items offered' do
      sales_analyst = se.analyst
      merchant = sales_analyst.merchants.find_by_id(12334160)

      sales_analyst.merchants_with_high_item_count.each do |merchant|
        expect(merchant).to be_a Merchant
        expect(sales_analyst.items.find_all_by_merchant_id(merchant.id).size).to be > 6
      end
      expect(sales_analyst.merchants_with_high_item_count.size).to be <= (475 * 0.16)
      expect(sales_analyst.merchants_with_high_item_count).not_to include(merchant)

      10.times { sales_analyst.items.create({
        :name        => "Amazing YoYo",
        :description => "It returns to you when you throw it",
        :unit_price  => BigDecimal(5.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334160}) }

      expect(sales_analyst.merchants_with_high_item_count).to include(merchant)
    end
  end

  describe '#avg_plus_std_dev' do
    it 'sums the average items per merchant and average items per merchant std dev and converts to integer' do
      sales_analyst = se.analyst

      expect(sales_analyst.avg_plus_std_dev).to be_a Integer
      expect(sales_analyst.avg_plus_std_dev).to eq(6)

      60.times { sales_analyst.items.create({
        :name        => "Mike Tyson's Ball Point Pen",
        :description => "Makes permanent markings",
        :unit_price  => BigDecimal(30_000.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334159}) }

      expect(sales_analyst.avg_plus_std_dev).to eq(7)
    end
  end

  describe '#average_item_price_for_merchant' do
    it 'returns the average price of a given merchants items' do
      sales_analyst = se.analyst

      expect(sales_analyst.average_item_price_for_merchant(12334159)).to be_a BigDecimal
      expect(sales_analyst.average_item_price_for_merchant(12334159).to_f).to eq(31.5)
      expect(sales_analyst.average_item_price_for_merchant(12334174).to_f).to eq(30.0)

      sales_analyst.items.create({
        :name        => "Mike Tyson's Ball Point Pen",
        :description => "Makes permanent markings",
        :unit_price  => BigDecimal(30_000.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334159})

      expect(sales_analyst.average_item_price_for_merchant(12334159).to_f).to eq(55.91)
    end
  end

  describe '#average_average_price_per_merchant' do
    it 'finds the average price across all merchants' do
      sales_analyst = se.analyst

      expect(sales_analyst.average_average_price_per_merchant).to be_a BigDecimal
      expect(sales_analyst.average_average_price_per_merchant.to_f).to eq(350.29)

      sales_analyst.items.create({
        :name        => "Abraham Lincoln's Fountain Pen",
        :description => "Makes artisinal permanent markings",
        :unit_price  => BigDecimal(523_300.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334159})

      expect(sales_analyst.average_average_price_per_merchant.to_f).to eq(351.29)
    end
  end

  describe '#average_item_price' do
    it 'finds the overall average item price' do
      sales_analyst = se.analyst

      expect(sales_analyst.average_item_price).to be_a BigDecimal
      expect(sales_analyst.average_item_price.to_f.round(2)).to eq(251.06)

      sales_analyst.items.create({
        :name        => "Abraham Lincoln's Fountain Pen",
        :description => "Makes artisinal permanent markings",
        :unit_price  => BigDecimal(523_300.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334159})

      expect(sales_analyst.average_item_price.to_f.round(2)).to eq(254.70)
    end
  end

  describe '#average_item_price_std_dev' do
    it 'returns std dev from the average price of items' do
      sales_analyst = se.analyst

      expect(sales_analyst.average_item_price_std_dev).to eq(2901.08)

      sales_analyst.items.create({
        :name        => "Abraham Lincoln's Fountain Pen",
        :description => "Makes artisinal permanent markings",
        :unit_price  => BigDecimal(523_300.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334159})

      expect(sales_analyst.average_item_price_std_dev).to eq(2903.14)
    end
  end

  describe '#array_of_items_price' do
    it 'returns an array of the price of each item in the item repo' do
      sales_analyst = se.analyst

      expect(sales_analyst.array_of_items_price.size).to eq(1367)

      sales_analyst.items.create({
        :name        => "Ball Point Pen",
        :description => "Makes permanent markings",
        :unit_price  => BigDecimal(3.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334159})

      expect(sales_analyst.array_of_items_price.size).to eq(1368)
      expect(sales_analyst.array_of_items_price.last).to eq(0.399e-1)
    end
  end

  describe '#golden_items' do
    it 'returns the items which have a price two standard deviations above the average price' do
      sales_analyst = se.analyst

      sales_analyst.golden_items.each do |item|
        expect(item).to be_a Item
        expect(item.unit_price_to_dollars).to be > 6053
      end

      expect(sales_analyst.golden_items.size).to be <= (1367 * 0.025)
      expect(sales_analyst.golden_items.size).to eq(5)

      sales_analyst.items.create({
        :name        => "Abraham Lincoln's Fountain Pen",
        :description => "Makes artisinal permanent markings",
        :unit_price  => BigDecimal(1_523_300.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 12334159})

      expect(sales_analyst.golden_items.size).to eq(6)
    end
  end

  describe '#average_invoices_per_merchant' do
    it 'return the average count of invoices per merchant' do
      sales_analyst = se.analyst

      expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
    end
  end
end
