require 'csv'
require 'BigDecimal'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'

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

  it "can find an invoice by id and return an array or or one or more matches" do
    expect(@invoice_item_repository.find_all_by_invoice_id(1)).to be_a(Array)
    expect(@invoice_item_repository.find_all_by_invoice_id(576)).to be_a(Array)
    expect(@invoice_item_repository.find_all_by_invoice_id(12210)).to be_a(Array)
  end

  it "can create a new invoice item" do
    attributes = {
        :item_id => 7,
        :invoice_id => 4986,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @invoice_item_repository.create(attributes)
    expect(@invoice_item_repository.all.last).to be_a(InvoiceItem)
    expect(@invoice_item_repository.all.last.id).to eq(21831)
    expect(@invoice_item_repository.all.last.invoice_id).to eq(4986)
  end

  it "can update the invoice item instance" do
    id = 183
    expect(@invoice_item_repository.find_by_id(id).quantity).to eq(3)

    attributes = {
        :quantity => 15,
        :unit_price => BigDecimal(15.99, 4),
      }

    @invoice_item_repository.update(id, attributes)
    expect(@invoice_item_repository.find_by_id(id).quantity).to eq(15)
    expect(@invoice_item_repository.find_by_id(id).unit_price).to eq(15.99)
  end

  it "can delete the invoice item instance with a corresponding id" do
    id = 487
    expect(@invoice_item_repository.find_by_id(id)).to be_a(InvoiceItem)
    expect(@invoice_item_repository.delete(id))
    expect(@invoice_item_repository.find_by_id(id)).to eq(nil)
  end
end
