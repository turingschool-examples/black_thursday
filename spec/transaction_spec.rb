require "Rspec"
require_relative "../lib/transaction"

describe Transaction do
  before :each do
    @t = Transaction.new({
      :id          => '1',
      :created_at  => '2016-01-11 09:34:06 UTC',
      :updated_at  => '2017-06-04 21:35:10 UTC',
      :invoice_id => '520',
      :credit_card_number => '4242424242424242',
      :credit_card_expiration_date => "0220",
      :result => "success",
    })
  end

  it "exists" do
    expect(@t).to be_an_instance_of(Transaction)
  end

  it '#attributes' do
    expect(@t.id).to eq 1
    expect(@t.credit_card_number).to eq "4242424242424242"
    expect(@t.invoice_id).to eq 520
    expect(@t.credit_card_expiration_date).to eq "0220"
    expect(@t.result).to eq :success
    expect(@t.created_at).to be_a Time
    expect(@t.updated_at).to be_a Time
  end
end
