require './lib/transaction_repository'

RSpec.describe TransactionRepository do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                       items: './data/items.csv',
                                       merchants: './data/merchants.csv',
                                       invoices: "./data/invoices.csv",
                                       invoice_items: './data/invoice_items.csv',
                                       transactions: './data/transactions.csv',
                                       customers: './data/customers.csv',
                                     })
  end

  it "exists" do
  expect(@engine.transactions).to be_an_instance_of(TransactionRepository)
  end

end
