require 'csv'
require './lib/invoice_item_repository'
require './lib/sales_engine'

RSpec.describe InvoiceItemRepository do
  before :each do
    @sales_engine = SalesEngine.from_csv({:invoice_items => "./data/invoice_items.csv"})
    @invoice_item = @sales_engine.invoice_items.find_by_id(6)
  end

  it 'exists' do

    expect(@invoice_item).to be_a InvoiceItem
  end

  it 'can return all invoice items' do

    expect(@invoice_item.all).to be_instance_of Array
  end
end
