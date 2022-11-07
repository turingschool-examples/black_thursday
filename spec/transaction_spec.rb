require_relative '../lib/transaction'
require 'time'

RSpec.describe Transaction do
  before(:each) do
    @time = Time.now.to_s
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

  it 'exists' do
    expect(@transaction).to be_a(Transaction)
  end

  it 'has an id' do
    expect(@transaction.id).to eq(6)
  end

  it 'has an invoice id' do
    expect(@transaction.invoice_id).to eq(8)
  end

  it 'has a credit card number' do
    expect(@transaction.credit_card_number).to eq("4242424242424242")
  end

  it 'has a credit card number expiration date' do
    expect(@transaction.credit_card_expiration_date).to eq("0220")
  end

  it 'has a result' do
    expect(@transaction.result).to eq(:success)
  end

  it 'has a time created at' do
    expect(@transaction.created_at).to eq(Time.parse(@time))
  end

  it 'has a time updated at' do
    expect(@transaction.updated_at).to eq Time.parse(@time)
  end
end