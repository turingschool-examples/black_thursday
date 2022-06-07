require 'csv'
require './lib/invoice_item_repository'
require './lib/sales_engine'

RSpec.describe InvoiceItemRepository do
  before :each do
    @sales_engine = SalesEngine.from_csv({:invoice_items => "./data/invoice_items.csv"})

    invoice_item = sales_engine.invoice_items.find_by_id(6)
  end

  it "exists" do
    expect(@sales_engine)
  end
end
