require'./lib/transaction'

RSpec.describe Transaction do
  before :each do
    @time = Time.now
    @transaction = Transaction.new({
        :id => 6,
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => @time,
        :updated_at => @time
        })
      end

  it "exists" do
    expect(@transaction).to be_a Transaction
  end

  it 'has attributes' do
    expect(@transaction.id).to eq(6)
    expect(@transaction.invoice_id).to eq(8)
    expect(@transaction.credit_card_number).to eq("4242424242424242")
    expect(@transaction.credit_card_expiration_date).to eq("0220")
    expect(@transaction.result).to eq("success")
    expect(@transaction.created_at).to be_a Time
    expect(@transaction.updated_at).to be_a Time
    expect(@transaction.created_at).to eq @time
    expect(@transaction.updated_at).to eq @time
  end
  
end
