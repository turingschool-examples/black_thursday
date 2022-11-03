require_relative "../lib/invoice_item_repository"
require_relative '../lib/sales_engine'

RSpec.describe ItemRepository do
  before :each do
    se = SalesEngine.from_csv({items: './data/items.csv', merchants: './data/merchants.csv',:invoice_items => "./data/invoice_items.csv"})
    sales_analyst = se.analyst
  end
end