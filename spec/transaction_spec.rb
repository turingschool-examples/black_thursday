require 'rspec'
require './lib/transaction'

describe Transaction do
  before (:each) do
    @t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => "02-26-2022",
      :updated_at => "02-27-2022"
      })
    end

  it 'exists' do
    expect(@t).to be_an_instance_of(Transaction)
  end

  it 'has an id' do
    expect(@t.id).to be(6)
  end

  it 'has an invoice id' do
    expect(@t.invoice_id).to be(8)
  end

  it 'has a credit_card_number' do
    expect(@t.credit_card_number).to eq("4242424242424242")
  end

  it 'has a credit_card_expiration_date' do
    expect(@t.credit_card_expiration_date).to eq("0220")
  end

  it 'has a result' do
    expect(@t.result).to eq("success")
  end

  it 'has created and updated times' do
    expect(@t.created_at).to eq("02-26-2022")
    expect(@t.updated_at).to eq("02-27-2022")
  end


end
