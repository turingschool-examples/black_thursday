require 'csv'
require_relative '../lib/transaction'

RSpec.describe Transaction do
  before :each do
    @t = Transaction.new({
    :id          => 6,
    :invoice_id => 8,
    :credit_card_number => '4242424242424242',
    :credit_card_expiration_date => '0220',
    :result     => 'success',
    :created_at  => Time.now,
    :updated_at  => Time.now,
  })
  end

  it 'exists' do
    expect(@t).to be_instance_of Transaction
  end

  it 'has an id' do
    expect(@t.id).to eq(6)
  end
  #
  it 'has an invoice id' do
    expect(@t.invoice_id).to eq(8)
  end

  it 'has a credit card number' do
    expect(@t.credit_card_number).to eq('4242424242424242')
  end
  #
  it 'has a credit card expiration date' do
    expect(@t.credit_card_expiration_date).to eq('0220')
  end
  #
  it 'has a result' do
    expect(@t.result).to eq('success')
  end
  #
  it 'has created_at' do
    expect(@t.created_at).to be_a Time
  end
  #
  it 'has updated_at' do
    expect(@t.updated_at).to be_a Time
  end
end
