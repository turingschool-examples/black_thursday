require'./lib/invoice_item_repository'
require'./lib/invoice_item'
# require'BigDecimal'

RSpec.describe InvoiceItemRepository do
  before :each do
    @sales_engine = InvoiceItemRepository.new("./data/invoice_items.csv")
  end

  it 'exists' do
    expect(@sales_engine).to be_a(InvoiceItemRepository)
  end

  it "returns all known Invoice Item instances" do
    expect(@sales_engine.all).to be_a Array
    expect(@sales_engine.all.count).to eq(21830)
  end
#
  it "can find by id" do
    expect(@sales_engine.find_by_id(1)).to eq(@sales_engine.all.first)
    expect(@sales_engine.find_by_id(8675309)).to eq(nil)
    expect(@sales_engine.find_by_id(1)).to be_a(InvoiceItem)
  end

  it "can find ALL by item id" do
    expect(@sales_engine.find_all_by_item_id(263519844).count).to eq 164
    expect(@sales_engine.find_all_by_item_id(8675309)).to eq([])
    expect(@sales_engine.find_all_by_item_id(263519844)).to be_a Array
  end

  it "can find all by invoice id" do
    expect(@sales_engine.find_all_by_invoice_id(1).count).to eq 0
    expect(@sales_engine.find_all_by_invoice_id(8675309)).to eq([])
    expect(@sales_engine.find_all_by_invoice_id(1)).to be_a Array
  end

  it 'can create Invoice Item instance' do
    x = Time.now
    last_id_number_in_csv = @sales_engine.all.last.id.to_i
    attributes = {
      :id => last_id_number_in_csv + 1,
      :item_id => 0356,
      :invoice_id => 067,
      :quantity => 99999999,
      :unit_price => 23,
      :created_at => x,
      :updated_at => x
    }

    expect(@sales_engine.create(attributes).id).to eq(21831)
    expect(@sales_engine.all.last).to be_a(InvoiceItem)
    expect(@sales_engine.all.count).to eq(0)
  end
#
#   it "can update(id, attributes) an merchant instance" do
#     attributes = {
#       name: "BryceGems"
#     }
#
#     @merchant_repository.update(12334105, attributes)
#
#     expect(@merchant_repository.find_by_id(12334105).name).to eq("BryceGems")
#     expect(@merchant_repository.find_by_name("Shopin1901")).to eq(nil)
#   end
#
#   it "can delete a merchant instance" do
#
#     expect(@merchant_repository.find_by_name("Shopin1901")).to be_a(Merchant)
#     @merchant_repository.delete(12334105)
#     expect(@merchant_repository.find_by_name("Shopin1901")).to eq(nil)
#   end
end
