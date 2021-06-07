require_relative './spec_helper'

RSpec.describe SalesAnalyst do
  context 'instantiation' do
    before :each do

      @se = SalesEngine.new({ items: 'spec/fixtures/items.csv', merchants: 'spec/fixtures/merchants.csv', invoices: 'spec/fixtures/invoices.csv' })
      @analyst = SalesAnalyst.new(@se)
    end

    it 'exists' do
      expect(@analyst).to be_an_instance_of(SalesAnalyst)
    end

    it 'has an engine' do
      expect(@analyst.engine).to eq(@se)
    end
  end

  context 'methods' do
    before :each do
      @se = SalesEngine.new({ items: 'spec/fixtures/items.csv', merchants: 'spec/fixtures/merchants.csv', invoices: 'spec/fixtures/invoices.csv'})
      @analyst = SalesAnalyst.new(@se)
    end

    it 'can calculate average items per merchant' do
      expect(@analyst.average_items_per_merchant).to eq(1.0)
    end

    it 'can calculate number of items per merchant' do
      expected = {
        @se.merchants.all[0] => 1,
        @se.merchants.all[1] => 1,
        @se.merchants.all[2] => 1,
        @se.merchants.all[3] => 1,
        @se.merchants.all[4] => 1,
        @se.merchants.all[5] => 1,
        @se.merchants.all[6] => 1,
        @se.merchants.all[7] => 1,
        @se.merchants.all[8] => 1,
        @se.merchants.all[9] => 1,
        @se.merchants.all[10] => 1,
        @se.merchants.all[11] => 1,
        @se.merchants.all[12] => 1,
        @se.merchants.all[13] => 1,
        @se.merchants.all[14] => 1,
        @se.merchants.all[15] => 1,
        @se.merchants.all[16] => 1,
        @se.merchants.all[17] => 1,
        @se.merchants.all[18] => 1,
        @se.merchants.all[19] => 1
      }

      expect(@analyst.items_per_merchant).to eq(expected)
    end

    it 'can calculate standard deviation' do
      numbers = [4, 5, 6]
      average = 5

      expect(@analyst.standard_dev(numbers, average)).to eq(1.00)
    end

    it 'can calculate standard deviation for items per merchant' do
      expect(@analyst.average_items_per_merchant_standard_deviation).to eq(0.0)
    end

    it 'can calculate the merchants with high item count' do
      expected = @se.merchants.all
      expect(@analyst.merchants_with_high_item_count).to eq(expected)
    end

    it 'can find the average price for a merchant by it' do
      merchant_id = @se.merchants.all[0].id
      expect(@analyst.average_item_price_for_merchant(merchant_id)).to eq(0.50)
    end

    it 'can determine average price for each merchant' do
      expected = {
        @se.merchants.all[0] => BigDecimal(0.50, 4),
        @se.merchants.all[1] => BigDecimal(0.12, 4),
        @se.merchants.all[2] => BigDecimal(0.80, 4),
        @se.merchants.all[3] => BigDecimal(11.00, 4),
        @se.merchants.all[4] => BigDecimal(5.50, 4),
        @se.merchants.all[5] => BigDecimal(0.40, 4),
        @se.merchants.all[6] => BigDecimal(0.25, 4),
        @se.merchants.all[7] => BigDecimal(0.50, 4),
        @se.merchants.all[8] => BigDecimal(9.50, 4),
        @se.merchants.all[9] => BigDecimal(8.50, 4),
        @se.merchants.all[10] => BigDecimal(0.05, 4),
        @se.merchants.all[11] => BigDecimal(0.35, 4),
        @se.merchants.all[12] => BigDecimal(0.05, 4),
        @se.merchants.all[13] => BigDecimal(0.10, 4),
        @se.merchants.all[14] => BigDecimal(0.60, 4),
        @se.merchants.all[15] => BigDecimal(1.10, 4),
        @se.merchants.all[16] => BigDecimal(12.00, 4),
        @se.merchants.all[17] => BigDecimal(2.50, 4),
        @se.merchants.all[18] => BigDecimal(0.30, 4),
        @se.merchants.all[19] => BigDecimal(4.00, 4)
      }

      expect(@analyst.average_item_price_per_merchant).to eq(expected)
    end

    it 'can calculate the average for the average price for each items per merchant' do
      expect(@analyst.average_average_price_per_merchant).to eq(BigDecimal(2.91, 4))
    end

    it 'can calculate standard deviation of item unit prices' do
      expect(@analyst.average_price_per_item_standard_deviation).to eq(4.07)
    end

    it 'can find items that are two standard deviations above the mean' do
      item2 = @se.items.all[16]
      expect(@analyst.golden_items).to eq([item2])
    end

    it 'can find the average invoices per merchant' do
      expect(@analyst.average_invoices_per_merchant).to eq(0.25)
    end

    it 'can group the number of invoices per merchant' do
      expected = {
        @se.merchants.all[0] => 1,
        @se.merchants.all[1] => 1,
        @se.merchants.all[2] => 1,
        @se.merchants.all[3] => 1,
        @se.merchants.all[4] => 1,
        @se.merchants.all[5] => 0,
        @se.merchants.all[6] => 0,
        @se.merchants.all[7] => 0,
        @se.merchants.all[8] => 0,
        @se.merchants.all[9] => 0,
        @se.merchants.all[10] => 0,
        @se.merchants.all[11] => 0,
        @se.merchants.all[12] => 0,
        @se.merchants.all[13] => 0,
        @se.merchants.all[14] => 0,
        @se.merchants.all[15] => 0,
        @se.merchants.all[16] => 0,
        @se.merchants.all[17] => 0,
        @se.merchants.all[18] => 0,
        @se.merchants.all[19] => 0
      }
      expect(@analyst.invoices_per_merchant).to eq(expected)
    end

    it 'can calculate standard deviation for invoices per merchant' do
      expect(@analyst.average_invoices_per_merchant_standard_deviation).to eq(0.44)
    end


  end
end
