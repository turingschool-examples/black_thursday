require_relative './spec_helper'

RSpec.describe InvoiceItemRepository do
  before :each do
    @sales_engine = SalesEngine.from_csv({
     :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoice => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
    })
    # @invoice_item = @sales_engine.invoice_items.find_by_id(6)
  end

  it 'is an InvoiceItemRepository' do
    expect(@sales_engine.invoice_item_repository).to be_instance_of(InvoiceItemRepository)
  end

end
