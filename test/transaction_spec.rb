require "./lib/invoice"
require "./lib/invoice_repository"
require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/item"
require "./lib/merchant_repository"
require "./lib/merchant"
require "./lib/transaction"

RSpec.describe Transaction do
  before(:each) do
  @transaction = Transaction.new ({
    :id => 3,
   :invoice_id => 750,
   :credit_card_number => "4271805778010747",
   :credit_card_expiration_date => "1220",
   :result => "success",
   :created_at => "2012-02-26 20:56:56 UTC",
   :updated_at => "2012-02-26 20:56:56 UTC"
    })
  end

  it "exist" do
    expect(@transaction).to be_a(Transaction)
  end

  it "has attributes" do
    expect(@transaction.id).to eq(3)
    expect(@transaction.invoice_id).to eq(750)
    expect(@transaction.credit_card_number).to eq("4271805778010747")
    expect(@transaction.credit_card_expiration_date).to eq("1220")
    expect(@transaction.result).to eq(:success)
    expect(@transaction.created_at).to eq(Time.parse("2012-02-26 20:56:56 UTC"))
    expect(@transaction.updated_at).to eq(Time.parse("2012-02-26 20:56:56 UTC"))
  end
end
