require "spec_helper"
require "./lib/sales_analyst"
require "./lib/merchant"
require "./lib/item"
require "./lib/sales_engine"
require "bigdecimal"
require "pry"

RSpec.describe SalesAnalyst do
  context "Iteration 1" do
    let(:sales_analyst) { engine.analyst }

    it "#average_items_per_merchant gives average number of items per merchant" do

      expect(sales_analyst.average_items_per_merchant).to eq 2.88
    end

    xit "#average_items_per_merchant_standard_deviation gives a standard deviation" do

      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq 3.26
    end

    xit "#merchants_with_high_item_count gives merchants with more than 1 standard deviation above average of offered items" do

      expect(sales_analyst.merchants_with_high_item_count).to eq 52
    end

    xit "#average_item_price_for_merchant gives average price per item of a given merchant" do
      merchant_id = 12334105

      expect(sales_analyst.average_item_price_for_merchant(merchant_id)).to eq 16.66
      expect(sales_analyst.average_item_price_for_merchant(merchant_id).class).to eq BigDecimal
    end

    xit "#average_average_price_per_merchant gives average price for all merchants" do

      expect(sales_analyst.average_average_price_per_merchant).to eq 350.29
      expect(sales_analyst.average_average_price_per_merchant.class).to eq BigDecimal
    end

    xit "#golden_items gives items 2 standard deviations above average item price" do

      expect(sales_analyst.golden_items.length).to eq 5
      expect(sales_analyst.golden_items.first.class).to eq Item
    end
  end
end
