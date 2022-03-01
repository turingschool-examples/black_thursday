# transaction spec
require_relative '../lib/transactions'
require 'pry'

RSpec.describe Transactions do
  before(:each) do
    @transaction = Transactions.new({
                                      id: 6,
                                      invoice_id: 8,
                                      credit_card_number: '4242424242424242',
                                      credit_card_expiration_date: '0220',
                                      result: 'success',
                                      created_at: '2012-02-26 20:56:56 UTC',
                                      updated_at: '2012-03-26 20:56:56 UTC'
                                    })
  end

  it '#id returns the transaction id' do
    expect(@transaction.id).to eq(6)
    expect(@transaction.id.class).to eq Integer
  end

  it '#credit_card_expiration_date returns the credit card expiration' do
    expect(@transaction.credit_card_expiration_date).to eq('0220')
    expect(@transaction.credit_card_expiration_date.class).to eq(String)
  end

  it '#result returns the result' do
    expect(@transaction.result).to eq :success
    expect(@transaction.result.class).to eq Symbol
  end

  it '#created_at returns a Time instance for the date the invoice item was created' do
    expect(@transaction.created_at).to eq Time.parse('2012-02-26 20:56:56 UTC')
    expect(@transaction.created_at.class).to eq(Time)
  end

  it '#updated_at returns a Time instance for the date the invoice item was last updated' do
    expect(@transaction.updated_at).to eq Time.parse('2012-03-26 20:56:56 UTC')
    expect(@transaction.updated_at.class).to eq Time
  end
end
