
require 'csv'
require 'time'
require './lib/sales_engine'

RSpec.describe Transaction do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                       items: './data/items.csv',
                                       merchants: './data/merchants.csv',
                                       invoices: './data/invoices.csv',
                                       invoice_items: './data/invoice_items.csv',
                                       transactions: './data/transactions.csv'
                                     })
  end

  it 'has attributes' do
    transaction_1 = @engine.transactions.all.first
    expect(transaction_1.id).to eq(1)
    expect(transaction_1.credit_card_expiration_date).to eq("0217")
    transaction_1 = @engine.transactions.all.last
    expect(transaction_1.id).to eq(4985)
    expect(transaction_1.credit_card_expiration_date).to eq("0913")
  end


end
