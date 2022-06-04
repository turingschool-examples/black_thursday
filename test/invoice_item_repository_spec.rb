require_relative './spec_helper'

RSpec.describe InvoiceItemRepository do
  before :each do
    @sales_engine = SalesEngine.from_csv({
     :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoice => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
    })
    @invoice_item = @sales_engine.invoice_items.find_by_id(6)
  end

  it 'is an InvoiceItemRepository' do
    expect(@sales_engine.invoice_items).to be_instance_of(InvoiceItemRepository)
  end

  it 'returns and array of all known InvoiceItem instances' do
    expect(@sales_engine.invoice_items.all.class).to eq(Array)
    expect(@sales_engine.invoice_items.all.count).to eq(21830)
    expect(@sales_engine.invoice_items.all[0].class).to eq(InvoiceItem)
  end

  it 'returns an instance of invoice item by id' do
    expect(@sales_engine.invoice_items.find_by_id(10).item_id).to eq(263523644)
    expect(@sales_engine.invoice_items.find_by_id(10).invoice_id).to eq(2)
    expect(@sales_engine.invoice_items.find_by_id(200000)).to eq(nil)
  end

  it 'returns an instance by invoice id' do
    expect(@sales_engine.invoice_items.find_all_by_invoice_id(100).length).to eq(3)
  end

  it 'creates a new invoice item instance' do
    attributes = {
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @sales_engine.invoice_items.create(attributes)
    expect(@sales_engine.invoice_items.find_by_id(21831).item_id).to eq(7)
  end

  it 'can update the quantity and unit price' do
    attributes = {
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @sales_engine.invoice_items.create(attributes)
    original_time = @sales_engine.invoice_items.find_by_id(21831).updated_at
    @sales_engine.invoice_items.update(21831, { quantity: 13})
    expect(@sales_engine.invoice_items.find_by_id(21831).quantity).to eq(13)
    expect(@sales_engine.invoice_items.find_by_id(21831).item_id).to eq 7
    expect(@sales_engine.invoice_items.find_by_id(21831).updated_at).to be > original_time
  end
end
