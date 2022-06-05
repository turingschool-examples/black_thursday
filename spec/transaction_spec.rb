require'./lib/transaction'

RSpec.describe Transaction do
  before :each do
    @sales_engine = Transaction.new("./data/transactions.csv")
  end

  it 'exists' do
    expect(@sales_engine).to be_a(Transaction)
  end

#   it "returns all known Invoice Item instances" do
#     expect(@sales_engine.all).to be_a Array
#     expect(@sales_engine.all.count).to eq(21830)
#   end
# #
#   it "can find by id" do
#     expect(@sales_engine.find_by_id(1)).to eq(@sales_engine.all.first)
#     expect(@sales_engine.find_by_id(8675309)).to eq(nil)
#     expect(@sales_engine.find_by_id(1)).to be_a(InvoiceItem)
#   end
#
#   it "can find ALL by item id" do
#     expect(@sales_engine.find_all_by_item_id(263519844).count).to eq 164
#     expect(@sales_engine.find_all_by_item_id(8675309)).to eq([])
#     expect(@sales_engine.find_all_by_item_id(263519844)).to be_a Array
#   end
#
#   it "can find all by invoice id" do
#     expect(@sales_engine.find_all_by_invoice_id(1).count).to eq 0
#     expect(@sales_engine.find_all_by_invoice_id(8675309)).to eq([])
#     expect(@sales_engine.find_all_by_invoice_id(1)).to be_a Array
#   end
#
#   it 'can create Invoice Item instance' do
#     x = Time.now
#     last_id_number_in_csv = @sales_engine.all.last.id.to_i
#     attributes = {
#       :id => nil,
#       :item_id => 0356,
#       :invoice_id => 067,
#       :quantity => 99999999,
#       :unit_price => 23,
#       :created_at => x,
#       :updated_at => x
#       }
#     expect(@sales_engine.create(attributes).last.id).to eq(21831)
#     expect(@sales_engine.all.last).to be_a(InvoiceItem)
#     expect(@sales_engine.all.count).to eq(21831)
#   end
# #
#   it "can update(id, attribute) on a invoice item instance" do
#     attributes = {
#       :quantity => 99999999,
#       :unit_price => 23,
#       }
#
#     @sales_engine.update(1, attributes)
#
#     expect(@sales_engine.find_by_id(1).quantity).to eq(99999999)
#     expect(@sales_engine.find_by_id(1).unit_price).to eq(23)
#     expect(@sales_engine.find_by_id(1).updated_at).to be_a Time
#   end
#
#   it "can delete a invoice item instance" do
#     expect(@sales_engine.find_by_id(1)).to be_a(InvoiceItem)
#     @sales_engine.delete(1)
#     expect(@sales_engine.find_by_id(1)).to eq(nil)
#   end
end
