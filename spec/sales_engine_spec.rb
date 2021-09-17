require_relative './lib/sales_engine'
require 'csv'

RSpec.describe SalesEngine do
  customers     = './data/sample_data/sample_customers.csv'
  invoice_items = './data/sample_data/sample_invoice_items.csv'
  invoices      = './data/sample_data/sample_invoices.csv'
  items         = './data/sample_data/sample_items.csv'
  merchant      = './data/sample_data/sample_merchants.csv'
  transactions  = './data/sample_data/sample_transactions.csv'

  locations = {
    customers:      customers_path,
    invoice_items:  invoice_items_path,
    invoices:       invoices_path,
    items:          items_path,
    merchant:       merchants_path,
    transactions:   transactions _path
    }

  sales_engine = SalesEngine.new(locations)
  sales_engine = SalesEngine.from_csv(locations)

  # it 'exists' do
  #   expect(sales_engine).to be_a(SalesEngine)
  # end
  #
  # xit '' do
  #    se = SalesEngine.from_csv({
  #      :items     => "./data/items.csv",
  #      :merchants => "./data/merchants.csv",
  #      })
  #   expect(se).not_to eq nil
  # end
  #
  # xit 'creates an array of item hashes' do
  #   se = SalesEngine.from_csv({
  #     :items     => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #     })
  #   # expect(SalesEngine.item_data).to eq("./data/items.csv")
  #   # expect(SalesEngine.merchant_data).to eq("./data/merchants.csv")
  # end
  #
  # xit 'has attributes' do
  #   se = SalesEngine.from_csv({
  #     :items     => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #     })
  #   expect(x).to eq("...")
  # end
  #
  # xit 'returns the merchants' do
  #   se = SalesEngine.from_csv({
  #     :items     => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #     })
  #     require "pry"; binding.pry
  #   expect(se[:merchants]).not_to be nil
  # end

end
