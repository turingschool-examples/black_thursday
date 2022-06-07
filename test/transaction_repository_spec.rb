require './lib/merchant'
require './lib/merchant_repository'
require './lib/item'
require './lib/item_repository'
require './lib/sales_engine'
require './lib/invoice'
require './lib/invoice_repository'
require './lib/transaction'
require './lib/transaction_repository'

describe InvoiceRepository do
  let(:sales_engine) {SalesEngine.from_csv({
     :items     => "./data/items.csv",
     :merchants => "./data/merchants.csv",
     :invoices => "./data/invoices.csv",
     :invoice_items => "./data/invoice_items.csv",
     :transactions => "./data/transactions.csv",
     :customers => "./data/customers.csv"
     })}
  let(:transaction) {sales_engine.transactions}

  it "exists" do
    expect(transaction).to be_an(TransactionRepository)
  end

  it "has attributes" do
    expect(transaction.all).to be_an(Array)
    expect(transaction.all.first.id).to eq(1)
    expect(transaction.all.first.invoice_id).to eq(2179)
    expect(transaction.all.first.credit_card_number).to eq("4068631943231473")
    expect(transaction.all.first.credit_card_expiration_date).to eq("0217")
    expect(transaction.all.first.created_at).to eq(Time.parse("2012-02-26 20:56:56 UTC"))
    expect(transaction.all.first.updated_at).to eq(Time.parse("2012-02-26 20:56:56 UTC"))
    expect(transaction.all.first.result).to eq(:success)
    expect(transaction.all.length).to eq(4985)
  end

  it 'can find by id' do
    transactionexample = transaction.all.first

    expect(transaction.find_by_id(1)).to eq(transactionexample)
    expect(transaction.find_by_id(100000)).to eq(nil)
  end

  it 'can find_all_by_invoice_id' do
    transactionexample = transaction.find_by_id(3)

    expect(transaction.find_all_by_invoice_id(1000000)).to eq([])
    expect(transaction.find_all_by_invoice_id(2179).length).to eq(2)
    expect(transaction.find_all_by_invoice_id(750).first).to eq(transactionexample)
  end

  it 'can find_all_by_credit_card_number' do
    transactionexample = transaction.find_by_id(3)

    expect(transaction.find_all_by_credit_card_number(1000000)).to eq([])
    expect(transaction.find_all_by_credit_card_number("4848466917766329").length).to eq(1)
    expect(transaction.find_all_by_credit_card_number("4271805778010747").first).to eq(transactionexample)
  end

  it 'can find_all_by_result' do
    transactionexample = transaction.find_by_id(9)

    expect(transaction.find_all_by_result(:whatever)).to eq([])
    expect(transaction.find_all_by_result(:success).length).to eq(4158)
    expect(transaction.find_all_by_result(:failed).length).to eq(827)
    expect(transaction.find_all_by_result(:failed).first).to eq(transactionexample)
  end

  it 'can create a new transaction' do
    attributes = {
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    expect(transaction.all.length).to eq(4985)
    transaction.create(attributes)
    expect(transaction.all.length).to eq(4986)
  end

  it 'can update a transaction' do
    attributes = {
      result: :failed
    }
    expect(transaction.find_by_id(1).result).to eq(:success)
    transaction.update(1, attributes)
    expect(transaction.find_by_id(1).result).to eq(:failed)
  end

  it 'can delete a transaction' do
    expect(transaction.all.length).to eq(4985)
    transaction.delete(3)
    expect(transaction.all.length).to eq(4984)
    transaction.delete(10000000)
    expect(transaction.all.length).to eq(4984)
  end

end
