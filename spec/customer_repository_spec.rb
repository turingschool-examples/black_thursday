require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'
require 'pry'

RSpec.describe CustomerRepository do
  before :each do
    @sales_engine = SalesEngine.from_csv({
      :items => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv',
      :transactions => './data/transactions.csv',
      :customers => './data/customers.csv'
    })
    @customer = @sales_engine.customers
  end

  it 'exists' do

    expect(@sales_engine.customers).to be_instance_of CustomerRepository
    expect(@customer).to be_instance_of CustomerRepository
  end
  #
  it 'can return an array of all Customer instances' do

    expect(@customer.all).to be_instance_of Array
    expect(@customer.all.length).to eq(1000)
    expect(@customer.all.first).to be_instance_of Customer
    expect(@customer.all.first.id).to eq(1)
  end
  # #
  it 'can find customers by ID' do

    expect(@customer.find_by_id(5005)).to eq(nil)
    expect(@customer.find_by_id(1)).to be_instance_of Customer
    expect(@customer.find_by_id(1).first_name).to eq('Joey')
  end
  #
  it 'can find all customers by first name' do
  #
    expect(@customer.find_all_by_first_name('Joey')).to be_a Array
    expect(@customer.find_all_by_first_name('Joey').first).to be_instance_of Customer
    expect(@customer.find_all_by_first_name('Joey').length).to eq(1)
  end
  # #
  it 'can find all customers by last name' do
  #
    expect(@customer.find_all_by_last_name('Ondricka')).to be_a Array
    expect(@customer.find_all_by_last_name('Ondricka').first).to be_instance_of Customer
    expect(@customer.find_all_by_last_name('Ondricka').length).to eq(3)
  end

  #
  it 'can create new transactions' do
    @attributes =   {
      :id => 1001,
      :first_name => 'Gauri',
      :last_name => 'Joshi',
      :created_at => Time.now,
      :updated_at => 12334105
    }
  #
    expect(@customer.create(@attributes)).to be_a Array
    expect(@customer.all.last).to be_a Customer
    expect(@customer.all.last.id).to eq(1001)
  end
  # #
  # it 'can update the credit_card_number, credit_card_expiration_date, and result on the transaction' do
  #
  #   @attributes = {result: 'failed', credit_card_number: 8888888888888888, credit_card_expiration_date: 1110}
  #
  #   expect(@transaction.all.first.result).to eq('success')
  #   expect(@transaction.all.first.credit_card_number).to eq(4068631943231473)
  #   expect(@transaction.all.first.credit_card_expiration_date).to eq(217)
  #
  #   @transaction.update(1, @attributes)
  #
  #   expect(@transaction.all.first.result).to eq('failed')
  #   expect(@transaction.all.first.credit_card_number).to eq(8888888888888888)
  #   expect(@transaction.all.first.credit_card_expiration_date).to eq(1110)
  # end
  #
  # #
  # it 'can delete a transaction' do
  #
  #   expect(@transaction.all.count).to eq(4985)
  #
  #   @transaction.delete(1)
  #
  #   expect(@transaction.find_by_id(1)).to be_nil
  #   expect(@transaction.all.count).to eq(4984)
  # end
end
