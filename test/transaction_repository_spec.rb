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

  it 'can find all by Invoice id' do
    expect(@sales_engine.transactions.find_all_by_invoice_id(2179).length).to eq(2)
  end

  it 'can find all by credit card number' do
    expect(@sales_engine.transactions.find_all_by_credit_card_number("4848466917766329").length).to eq(1)
  end

  it 'can find all by result' do
    expect(@sales_engine.transactions.find_all_by_result(:success).length).to eq(4158)
    expect(@sales_engine.transactions.find_all_by_result(:success)[0].class).to eq(Transaction)
  end

  it 'can create a new Transaction' do
    attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @sales_engine.transactions.create(attributes)
    expect(@sales_engine.transactions.find_by_id(4986).invoice_id).to eq(8)
  end

  it 'can create new attributes for a Transaction' do
    attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @sales_engine.transactions.create(attributes)
    original_time = @sales_engine.transactions.find_by_id(4986).updated_at
    updates = {result: :failed}
    @sales_engine.transactions.update(4986, updates)
    expect(@sales_engine.transactions.find_by_id(4986).result).to eq(:failed)
    expect(@sales_engine.transactions.find_by_id(4986).credit_card_expiration_date).to eq("0220")
    expect(@sales_engine.transactions.find_by_id(4986).updated_at).to be > original_time
  end
end
