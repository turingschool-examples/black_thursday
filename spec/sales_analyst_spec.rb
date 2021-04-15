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

      expect(sales_analyst.average_items_per_merchant).to eq(0.75)
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
end
