require_relative './spec_helper'

RSpec.describe TransactionRepository do
  before :each do
  @sales_engine = SalesEngine.from_csv({
   :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoice => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"
  })
  @t = Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
  })
  end

  it 'is an instance of TransactionRepository' do
    expect(@sales_engine.transactions).to be_instance_of(TransactionRepository)
  end

  it 'has an array of Transactions' do
    expect(@sales_engine.transactions.all[0].class).to eq(Transaction)
    expect(@sales_engine.transactions.all.class).to eq(Array)
    expect(@sales_engine.transactions.all.count).to eq(4985)
  end

  it 'can find by id' do
    expect(@sales_engine.transactions.find_by_id(2).class).to eq(Transaction)
  end
end
