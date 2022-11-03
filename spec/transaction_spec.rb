require './lib/transaction'
require './lib/transaction_repository'

RSpec.describe Transaction do
  let!(:transaction){Transaction.new({
  :id => 6,
  :invoice_id => 8,
  :credit_card_number => "4242424242424242",
  :credit_card_expiration_date => "0220",
  :result => "success",
  :created_at => Time.now,
  :updated_at => Time.now
})}

  it 'can return an id' do
    expect(transaction.id).to eq()
  end

  it 'can return nil if it is not within' do
    expect(transaction.id).to eq(nil)
    expect(transaction.id).to eq(nil)
  end

  it 'returns the invoice id' do
    expect(transaction.invoice_id).to eq()
  end

  it 'can return nil if it is not within' do
    expect(transaction.invoice_id).to eq(nil)
    expect(transaction.invoice_id).to eq(nil)
  end

  it 'can return creadit card number' do
    expect(transaction.credit_card_number).to eq()
  end

  it 'can return nil if it is not within' do
    expect(transaction.credit_card_number).to eq(nil)
    expect(transaction.credit_card_number).to eq(nil)
  end

  it 'returns the credit card experation date' do
    expect(transaction.credit_card_expiration_date).to eq()
  end

  it 'can return nil if it is not within' do
    expect(transaction.credit_card_expiration_date).to eq(nil)
    expect(transaction.credit_card_expiration_date).to eq(nil)
  end

  it 'returns the transaction results' do
    expect(transaction.result).to eq()
  end

  it 'can return nil if it is not within' do
    expect(transaction.result).to eq(nil)
    expect(transaction.result).to eq(nil)
  end

  it 'returns the time instance for when the transaction was first created' do
    expect(transaction.created).to eq()
  end

  it 'can return nil if it is not within' do
    expect(transaction.created).to eq(nil)
    expect(transaction.created).to eq(nil)
  end

  it 'returns the time instance for the date the transaction was last modified' do
    expect(transaction.updated_at).to eq()
  end
  
  it 'can return nil if it is not within' do
    expect(transaction.updated_at).to eq(nil)
    expect(transaction.updated_at).to eq(nil)
  end
end