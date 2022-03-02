# require "spec_helper"
require "./lib/sales_analyst"
require "./lib/merchant_repo"
require "./lib/item_repo"
require "./lib/invoice_repo"
require "./lib/customer_repo"
require "./lib/transaction_repo"
require "./lib/invoice_item_repo"
require "./lib/sales_engine"
require "bigdecimal"
require "pry"

RSpec.describe SalesAnalyst do

    let(:se) do
      SalesEngine.from_csv({
        items: "./data/items.csv",
        merchants: "./data/merchants.csv",
        invoices: "./data/invoices.csv",
        customers: "./data/customers.csv",
        transactions: "./data/transactions.csv",
        invoice_items: "./data/invoice_items.csv"
      })
    end

    let(:sa) { se.analyst }

    it "exists" do
      expect(sa).to be_an_instance_of(SalesAnalyst)
    end

    it "#average_items_per_merchant gives average number of items per merchant" do
      expect(sa.average_items_per_merchant).to eq 2.88
    end

    it "#total_items_per_merchant gives total number of items per merchant" do
      expect(sa.total_items_per_merchant).to be_an_instance_of(Array)
    end

    it "#average_items_per_merchant_standard_deviation gives a standard deviation" do
      expect(sa.average_items_per_merchant_standard_deviation).to eq 3.26
    end

    it "#merchants_with_high_item_count gives merchants with more than 1 standard deviation above average of offered items" do
      expect(sa.merchants_with_high_item_count.count).to eq 52
      expect(sa.merchants_with_high_item_count.first.class).to eq Merchant
    end

    it "#average_item_price_for_merchant gives average price per item of a given merchant" do
      merchant_id = 12334105

      expect(sa.average_item_price_for_merchant(merchant_id)).to eq 16.66
    end

    xit "#average_average_price_per_merchant gives average price for all merchants" do
      expect(sa.average_average_price_per_merchant).to eq 350.29
    end

    xit "#golden_items gives items 2 standard deviations above average item price" do
      expect(sa.golden_items.length).to eq 5
      expect(sa.golden_items.first.class).to eq Item
    end
  end
