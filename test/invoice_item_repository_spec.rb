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
    binding.pry
  end

  xit 'returns an instance of invoice item by id' do
    expect(@sales_engine.invoice_items.find_by_id(6)).to eq(@invoice_item)
    binding.pry
  end

end
