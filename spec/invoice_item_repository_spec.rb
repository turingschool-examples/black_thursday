require_relative "../lib/invoice_item_repository"
require_relative '../lib/sales_engine'

RSpec.describe InvoiceItemRepository do
  before :each do
    @se = SalesEngine.from_csv({items: './data/items.csv', merchants: './data/merchants.csv',:invoice_items => "./data/invoice_items.csv"})
    @sales_analyst = @se.analyst
  end

  it 'exists and has invoice items' do
    expect(@sales_analyst.engine.invoice_items).to be_a InvoiceItemRepository
    expect(@sales_analyst.engine.invoice_items.all.first).to be_a InvoiceItem
  end

  it 'can find an invoice item by id' do
    expect(@sales_analyst.engine.invoice_items.find_by_id(76).item_id).to eq 263417825
  end

  it 'can find an invoice item by item id' do
    expect(@sales_analyst.engine.invoice_items.find_by_item_id(263417825)).id.to eq 76
  end
end