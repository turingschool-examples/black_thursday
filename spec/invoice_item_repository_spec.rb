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

  it 'can find all invoice items by item id' do
    expect(@sales_analyst.engine.invoice_items.find_all_by_item_id(263417825)[0].id).to eq 76
  end

  it 'can create new invoice items' do
    @sales_analyst.engine.invoice_items.create({
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4)
    })

    expect(@sales_analyst.engine.invoice_items.all.last.item_id).to eq 7
    expect(@sales_analyst.engine.invoice_items.all.last.invoice_id).to eq 8
  end

  it 'can update an invoice item' do
    @sales_analyst.engine.invoice_items.update(79, {
      :quantity => 48,
      :unit_price => 1099
    })

    expect(@sales_analyst.engine.invoice_items.find_by_id(79).quantity).to eq 48
    expect(@sales_analyst.engine.invoice_items.find_by_id(79).unit_price_to_dollars).to eq 10.99
  end

  it 'can delete an invoice item' do
    @sales_analyst.engine.invoice_items.delete(79)

    expect(@sales_analyst.engine.invoice_items.find_by_id(79)).to eq nil
  end
end