require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/item'
require './lib/sales_analyst'
require './lib/transaction'
require './lib/transaction_repository'

RSpec.describe TransactionRepository do
  let!(:transaction_repository) {TransactionRepository.new('./data/transactions.csv', nil)}

  it 'is an transaction repository' do
    require 'pry'; binding.pry
    expect(transaction_repository).to be_a(TransactionRepository)
  end

  it 'can return all know transaction instances' do
    expect(transaction_repository.all).to eq()
  end

  it 'can return nil if it is not within' do
    expect(transaction_repository.all).to eq(nil)
    expect(transaction_repository.all).to eq(nil)
  end

  it 'can return transaction with matching id' do
    expect(transaction_repository.find_by_id()).to eq()
  end

  it 'can return nil if it is not within' do
    expect(transaction_repository.find_by_id()).to eq(nil)
    expect(transaction_repository.find_by_id()).to eq(nil)
  end

  it 'can find all items with matching id in an array' do
    expect(transaction_repository.find_all_by_item_id()).to eq([])
  end

  it 'returns nil if not valid item id' do
    expect(transaction_repository.find_all_by_item_id()).to eq(nil)
    expect(transaction_repository.find_all_by_item_id()).to eq(nil)
  end

  it 'can find all invoices with matching id in an array' do
    expect(transaction_repository.find_all_by_invoice_id()).to eq([])
  end

  it 'returns nil if not valid invoice id' do
    expect(transaction_repository.find_all_by_invoice_id()).to eq(nil)
    expect(transaction_repository.find_all_by_invoice_id()).to eq(nil)
  end

  it 'can create a new invoice instance with attributes' do
    expect(transaction_repository.create()).to eq()
  end

  it 'gives the new invoice instance the highest id + 1' do
    expect(transaction_repository.all.last.id).to eq()

    transaction_repository.create()

    expect(transaction_repository.all.last.id).to eq()
  end

  it 'can update a merchant (by id) with new attributes' do
  #will also change the invoices updated_at_attribute to current time
    expect(transaction_repository.find_by_id().name).to eq()

    transaction_repository.update(',')

    expect(transaction_repository.find_by_id().name).to eq()
  end

  it 'can delete an invoice instance by supplied id' do
    expect(transaction_repository.all.length).to eq()
    expect(transaction_repository.all).to eq()

    transaction_repository.delete()

    expect(transaction_repository.all.length).to eq()
    expect(transaction_repository.all).to eq()
  end


end