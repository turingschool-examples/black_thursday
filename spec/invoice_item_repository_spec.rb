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

  it "can return an array of all known invoice item instances" do
    expect(@invoice_item_repository.all).to be_a(Array)
    expect(@invoice_item_repository.all.length).to eq(21830)
    expect(@invoice_item_repository.all.first).to be_a(InvoiceItem)
    expect(@invoice_item_repository.all.first.id).to eq("1")
    expect(@invoice_item_repository.all.first.quantity).to eq("5")
  end
end
