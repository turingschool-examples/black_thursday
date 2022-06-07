require 'csv'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

RSpec.describe InvoiceItemRepository do
  before :each do
    @sales_engine = SalesEngine.from_csv({:invoice_items => './data/invoice_items.csv'})
    @invoice_item = @sales_engine.invoice_items.find_by_id(6)
  end

  it 'exists' do

    expect(@invoice_item).to be_a InvoiceItem
  end

  it 'can return all invoice items' do

    expect(@sales_engine.invoice_items.all).to be_a Array
    expect(@sales_engine.invoice_items.all.length).to eq(21830)
  end

  it 'can find an invoice item by ID' do

    expect(@sales_engine.invoice_items.find_by_id(6)).to be_a InvoiceItem
  end

  it 'can find all invoice items by item ID' do

    expect(@sales_engine.invoice_items.find_all_by_item_id(263451719)).to be_a Array
    expect(@sales_engine.invoice_items.find_all_by_item_id(263451719).length).to eq(13)
  end

  it 'can find all invoice items by invoice ID' do

    expect(@sales_engine.invoice_items.find_all_by_invoice_id(99999999)).to eq([])
    expect(@sales_engine.invoice_items.find_all_by_invoice_id(1).length).to eq(8)
  end

  it 'create new invoice items with attributes' do
    attributes = {
      :id => 77,
      :item_id => 0000000,
      :invoice_id => 0000000,
      :quantity => 000,
      :unit_price => 20,
      :created_at => Time.now,
      :updated_at => Time.now
    }

    expect(@sales_engine.invoice_items.all.last.id).to eq(21830)

    @sales_engine.invoice_items.create(attributes)

    expect(@sales_engine.invoice_items.all.last.id).to eq(21831)
  end

  it 'can update invoice items' do

  end
end
