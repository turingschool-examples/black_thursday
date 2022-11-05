require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require 'bigdecimal'

RSpec.describe SalesAnalyst do
  let(:se) {SalesEngine.from_csv({
    items: "./data/items.csv",
    merchants: "./data/merchants.csv"
    })}

  it 'exists' do
    sales_analyst = SalesAnalyst.new(ItemRepository.new, MerchantRepository.new)

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

      expect(sales_analyst.average_items_per_merchant).not_to eq(2.88)
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

      expect(sales_analyst.average_items_per_merchant_standard_deviation).not_to eq(3.26)
    end
  end

  describe '#merchants_with_high_item_count' do
    it 'returns merchants who are more than one standard deviation above average items offered' do
      sales_analyst = se.analyst

      sales_analyst.merchants_with_high_item_count.each do |merchant|
        expect(merchant).to be_a Merchant
        expect(sales_analyst.items.find_all_by_merchant_id(merchant.id).size).to be > 6
      end
      expect(sales_analyst.merchants_with_high_item_count.count).to be <= (475 * 0.16)
    end
  end

  describe '#average_item_price_for_merchant' do
    it 'returns the average price of a given merchants items' do
      sales_analyst = se.analyst

      expect(sales_analyst.average_item_price_for_merchant(12334159)).to be_a BigDecimal
    end
  end

  describe '#average_average_price_per_merchant' do
    it 'finds the average price across all merchants' do
      sales_analyst = se.analyst

      expect(sales_analyst.average_average_price_per_merchant).to be_a BigDecimal
    end
  end

  describe '#golden_items' do
    it 'returns the items which have a price two standard deviations above the average price' do
      sales_analyst = se.analyst

      sales_analyst.golden_items.each do |item|
        expect(item).to be_a Item
      end

      expect(sales_analyst.golden_items.size).to be <= (1367 * 0.025)
    end
  end
end
