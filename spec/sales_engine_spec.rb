require './lib/sales_engine'
require 'csv'

RSpec.describe SalesEngine do
  # customers_path     = './data/sample_data/sample_customers.csv'
  # invoice_items_path = './data/sample_data/sample_invoice_items.csv'
  # invoices_path      = './data/sample_data/sample_invoices.csv'
  # items_path         = './data/sample_data/sample_items.csv'
  # merchants_path     = './data/sample_data/sample_merchants.csv'
  # transactions_path  = './data/sample_data/sample_transactions.csv'
  #
  # data = {
  #   customers:      customers_path,
  #   invoice_items:  invoice_items_path,
  #   invoices:       invoices_path,
  #   items:          items_path,
  #   merchants:      merchants_path,
  #   transactions:   transactions_path
  #   }
  #
  # # sales_engine = SalesEngine.new(data)
  # sales_engine = SalesEngine.from_csv(data)

  it 'exists' do

    customers_path     = './data/customers.csv'
    invoice_items_path = './data/invoice_items.csv'
    invoices_path      = './data/invoices.csv'
    items_path         = './data/items.csv'
    merchants_path     = './data/merchants.csv'
    transactions_path  = './data/transactions.csv'

    data = {
      customers:      customers_path,
      invoice_items:  invoice_items_path,
      invoices:       invoices_path,
      items:          items_path,
      merchants:      merchants_path,
      transactions:   transactions_path
      }


    sales_engine = SalesEngine.new(data)
    sales_engine = SalesEngine.from_csv(data)
    require "pry"; binding.pry

    expect(sales_engine).to be_a(SalesEngine)
  end
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
