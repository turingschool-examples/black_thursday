require 'csv'
require 'invoice_item'
require 'invoice_item_repository'

RSpec.describe InvoiceItemRepository do
  before :each do
    @invoice_item_repository = InvoiceItemRepository.new("./data/invoice_items.csv")
  end

  it "exists" do
    expect(@invoice_item_repository).to be_a(InvoiceItemRepository)
  end
end
