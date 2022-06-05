require './lib/transaction_repository'
require './lib/transaction'

RSpec.describe TransactionRepository do
  before :each do
    @sales_engine = TransactionRepository.new("./data/transactions.csv")
  end

  it 'exists' do
    expect(@sales_engine).to be_a(TransactionRepository)
  end

  it "returns all known Transaction instances" do
    expect(@sales_engine.all).to be_a Array
    expect(@sales_engine.all.count).to eq(4985)
  end

  it "can find by id" do
    expect(@sales_engine.find_by_id(1)).to eq(@sales_engine.all.first)
    expect(@sales_engine.find_by_id(8675309)).to eq(nil)
    expect(@sales_engine.find_by_id(1)).to be_a(Transaction)
  end

  it "can find ALL by invoice id" do
    expect(@sales_engine.find_all_by_invoice_id(2179).count).to eq 2
    expect(@sales_engine.find_all_by_invoice_id(8675309)).to eq([])
    expect(@sales_engine.find_all_by_invoice_id(2179)).to be_a Array
  end
#
  it "can find all by credit_card_number" do
    expect(@sales_engine.find_all_by_credit_card_number(4068631943231473).count).to eq 0
    expect(@sales_engine.find_all_by_credit_card_number(8675309)).to eq([])
    expect(@sales_engine.find_all_by_credit_card_number(4068631943231473)).to be_a Array
  end
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
