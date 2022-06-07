require "./lib/invoice_item"
require "Rspec"

RSpec.describe InvoiceItem do

  it 'exists' do
    invoiceitem = InvoiceItem.new
    expect(invoiceitem).to be_an_instance_of(InvoiceItem)
  end
end
