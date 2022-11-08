require './lib/requirements'

RSpec.describe TransactionRepository do
  let!(:transaction_repository) {TransactionRepository.new('./data/transactions.csv', nil)}

  it 'is an transaction repository' do
    expect(transaction_repository).to be_a(TransactionRepository)
  end

  it 'can return all know transaction instances' do
    expect(transaction_repository.all.length).to eq(4985)
  end

  it 'can return transaction with matching id' do
    expect(transaction_repository.find_by_id(1)).to eq(transaction_repository.all[0])
  end

  it 'can return nil if it is not within' do
    expect(transaction_repository.find_by_id(5000)).to eq(nil)
  end

  it 'can find all matching an invoice id in an array' do
    expect(transaction_repository.find_all_by_invoice_id(8)).to eq([transaction_repository.all[534], transaction_repository.all[2651]])
    expect(transaction_repository.find_all_by_invoice_id(4988)).to eq([])
  end

  it 'can find all by credit card number in an array' do
    expect(transaction_repository.find_all_by_credit_card_number("4271805778010747")).to eq([transaction_repository.all[2]])
    expect(transaction_repository.find_all_by_credit_card_number("4444444444444444")).to eq([])
  end

  it 'can find all transaction by result' do
    expect(transaction_repository.find_all_by_result(:failed).length).to eq(827)
  end

  it 'can create a new transaction instance with attributes and the highest id + 1' do
    expect(transaction_repository.all.length).to eq(4985)
    expect(transaction_repository.all.last.id).to eq(4985)
    
    transaction_repository.create({:invoice_id => 8, :credit_card_number => 424242424, :credit_card_expiration_date => 0022, :result => :success})
    
    expect(transaction_repository.all.length).to eq(4986)
    expect(transaction_repository.all.last.id).to eq(4986)
  end

  it 'can update a merchant (by id) with new attributes' do
  #will also change the invoices updated_at_attribute to current time
    expect(transaction_repository.find_by_id(9).result).to eq(:failed)

    transaction_repository.update(9, {:result => :success})

    expect(transaction_repository.find_by_id(9).result).to eq(:success)
  end

  it 'can delete an invoice instance by supplied id' do
    expect(transaction_repository.all.length).to eq(4985)
    transaction_repository.delete(6)
    expect(transaction_repository.all.length).to eq(4984)
  end
end