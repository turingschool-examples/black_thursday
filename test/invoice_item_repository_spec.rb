require "./lib/sales_engine"
require "./lib/sales_analyst"
require "./lib/invoice_item"
require "./lib/invoice_item_repository"

RSpec.describe InvoiceItemRepository do
let(:sales_engine) {SalesEngine.from_csv({
   :items     => "./data/items.csv",
   :merchants => "./data/merchants.csv",
   :invoices => "./data/invoices.csv",
   :invoice_items => "./data/invoice_items.csv",
   :transactions => "./data/transactions.csv",
   :customers => "./data/customers.csv"
   })}
let(:invoice_item) {sales_engine.invoice_items}

  it "exists" do
    expect(invoice_item).to be_an(InvoiceItemRepository)
  end

  it "has attributes" do
    expect(invoice_item.all).to be_an(Array)
    expect(invoice_item.all.count).to eq(21830)
  end

  it "can find by id" do
    expect(invoice_item.find_by_id(6).quantity).to eq(5)
    expect(invoice_item.find_by_id(6).unit_price).to eq(521)
    expect(invoice_item.find_by_id(123123123123123)).to eq(nil)
  end

  it "can find ALL by item id" do
    expect(invoice_item.find_all_by_item_id(263523644)).to be_an(Array)
    expect(invoice_item.find_all_by_item_id(263523644).count).to eq(19)
    expect(invoice_item.find_all_by_item_id(0)).to eq([])
  end

  it "can find ALL by invoice id" do
    expect(invoice_item.find_all_by_invoice_id(1)).to be_an(Array)
    expect(invoice_item.find_all_by_invoice_id(1).count).to eq(8)
    expect(invoice_item.find_all_by_invoice_id(1).first.id).to eq(1)
    expect(invoice_item.find_all_by_invoice_id(1).last.id).to eq(8)
    expect(invoice_item.find_all_by_invoice_id(1000000000)).to eq([])
  end

  it "can create an instance of invoice item" do
    attributes = {
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      }
      expect(invoice_item.all.count).to eq(21830)
      invoice_item.create(attributes)
      expect(invoice_item.find_by_id(21831).item_id).to eq(7)
      expect(invoice_item.all.count).to eq(21831)
  end

  it "can update the instance of invoice item" do
    attributes = {
      :quantity => 10,
      :unit_price => BigDecimal(10.99, 4),
    }
    expect(invoice_item.find_by_id(21830).quantity).to eq(4)
    invoice_item.update(21830, attributes)
    expect(invoice_item.find_by_id(21829).quantity).to eq(10)
    expect(invoice_item.find_by_id(10000000000)).to eq(nil)
  end

  it "can delete an instance of invoice item" do
    expect(invoice_item.all.count).to eq(21830)
    invoice_item.delete(21830)
    expect(invoice_item.all.count).to eq(21829)
    expect(invoice_item.find_by_id(21830)).to eq(nil)
  end
end
