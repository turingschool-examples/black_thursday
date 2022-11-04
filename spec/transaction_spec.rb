require './lib/transaction'

RSpec.describe Transaction do
  let(:transaction) {Transaction.new({
    :id => 6, 
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date  => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
  })}

  it 'exists and takes in info and gives access to them' do
    @time_now = Time.parse("2022-11-03 18:56:21.000000000 -0700")
    allow(Time).to receive(:now).and_return(@time_now)

    expect(transaction).to be_a(Transaction)
    expect(transaction.id).to eq(6)
    expect(transaction.invoice_id).to eq(8)
    expect(transaction.credit_card_number).to eq("4242424242424242")
    expect(transaction.credit_card_expiration_date).to eq("0220")
    expect(transaction.result).to eq(:success)
    expect(transaction.created_at).to eq(@time_now)
    expect(transaction.updated_at).to eq(@time_now)
  end
end
