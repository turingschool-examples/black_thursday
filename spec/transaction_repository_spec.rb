require '../lib/invoice_repository'
require '../lib/transaction_repository'
require '../lib/sales_engine'

RSpec.describe TransactionRepository do
  before :each do
    @sales_engine = SalesEngine.from_csv({
      :items => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv',
      :transactions => './data/transactions.csv'
    })
    @transaction = @sales_engine.transactions
  end


  it 'exists' do

    expect(@sales_engine.transactions).to be_instance_of TransactionRepository
    expect(@transaction).to be_instance_of TransactionRepository
  end
  #
  it 'can return an array of all Transaction instances' do

    expect(@transaction.all).to be_instance_of Array
    expect(@transaction.all.length).to eq(4985)
    expect(@transaction.all.first).to be_instance_of Transaction
    expect(@transaction.all.first.id).to eq(1)
  end
  #
  it 'can find transactions by ID' do

    expect(@transaction.find_by_id(234234239)).to eq(nil)
    expect(@transaction.find_by_id(1)).to be_instance_of Transaction
    expect(@transaction.find_by_id(1).result).to eq('success')
  end
  #
  it 'can find all transactions by invoice id' do

    expect(@transaction.find_all_by_invoice_id(1)).to be_a Array
    expect(@transaction.find_all_by_invoice_id(1).first).to be_instance_of Transaction
    expect(@transaction.find_all_by_invoice_id(1).length).to eq(2)
  end
  #
  it 'can find all by credit card number' do

    expect(@transaction.find_all_by_credit_card_number(2222222222222222)).to eq([])
    expect(@transaction.find_all_by_credit_card_number(4007233416896135)).to be_instance_of Array
    expect(@transaction.find_all_by_credit_card_number(4007233416896135).length).to eq(1)
    expect(@transaction.find_all_by_credit_card_number(4007233416896135).first).to be_instance_of Transaction
  end
  #
  it 'can find all by result' do

    expect(@transaction.find_all_by_result('doesnotexist')).to eq([])
    expect(@transaction.find_all_by_result('failed')).to be_instance_of Array
  end
  #
  it 'can create new transactions' do
    attributes =   {
      :id => 4986,
      :invoice_id => 666,
      :credit_card_number => 17979797979797979,
      :credit_card_expiration_date => 0431,
      :result => 'success',
      :created_at => Time.now,
      :updated_at => 12334105
    }

    expect(@transaction.create(attributes)).to be_a Array
    expect(@transaction.all.last).to be_a Transaction
    expect(@transaction.all.last.id).to eq(4986)
    expect(@transaction.all.last.invoice_id).to eq(666)
  end
  #
  it 'can update the credit_card_number, credit_card_expiration_date, and result on the transaction' do

    attributes = {result: 'failed'}
   ## NOTE: this needs to be included in attributes above:
   ##credit_card_number: 8888888888888888, credit_card_expiration_date: 1110
    expect(@transaction.all.first.result).to eq('success')
    # expect(@transaction.all.first.credit_card_number).to eq(4068631943231473)
    # expect(@transaction.all.first.credit_card_expiration_date).to eq(0217)
    @transaction.update(1, attributes)

    expect(@transaction.all.first.result).to eq('failed')
    # expect(@transaction.all.first.credit_card_number).to eq(8888888888888888)
    # expect(@transaction.all.first.credit_card_expiration_date).to eq(1110)
  end

  #
  xit 'can delete a transaction' do

    expect(@transaction.all.count).to eq(4985)

    @transaction.delete(1)

    expect(@transaction.find_by_id(1)).to be_nil
    expect(@transction.all.count).to eq(4984)
  end
end
