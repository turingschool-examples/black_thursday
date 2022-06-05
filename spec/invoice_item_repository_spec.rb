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
    expect(@invoice_item_repository.all.first.id).to eq(1)
    expect(@invoice_item_repository.all.first.quantity).to eq(5)
  end

  it "returns nil or an instance of invoice item with a matching id" do
    expect(@invoice_item_repository.find_by_id(0)).to eq nil
    expect(@invoice_item_repository.find_by_id(72)).to be_a(InvoiceItem)
    expect(@invoice_item_repository.find_by_id(4345)).to be_a(InvoiceItem)
  end
end
