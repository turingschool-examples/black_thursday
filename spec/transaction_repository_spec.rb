require 'rspec'
require './lib/transaction_repository'

describe TransactionRepository do
  before (:each) do
    @tr = TransactionRepository.new('./data/transactions.csv')
  end

  describe '#initialize' do
    it 'exists' do
      expect(@tr).to be_an_instance_of(TransactionRepository)
    end

    it 'creates an array of instances of transactions' do
      expect(@tr.repository.class).to be(Array)
      transaction = @tr.repository.sample
      expect(transaction).to be_an_instance_of(Transaction)
    end
  end

  describe '#all' do
    it 'returns all instances of Transaction in the repository' do
      expect(@tr.all).to eq(@tr.repository)
    end
  end

  describe '#find_by_id' do
    it 'finds the transaction of a specific id' do
      transaction = @tr.find_by_id(17)
      expect(transaction.id).to eq(17)
      expect(transaction.invoice_id).to eq("2850")
    end
  end

  describe '#find_all_by_credit_card_number' do
    it 'finds all transactions with a specific card number' do
      transaction = @tr.find_all_by_credit_card_number("4349426879923290")

      expect(transaction.class).to eq(Array)
      expect(transaction.sample.credit_card_number).to eq("4349426879923290")

      transaction = @tr.find_all_by_credit_card_number("9898989898989898")
      expect(transaction).to eq(nil)
    end
  end

  describe '#find_all_by_result' do
    it 'can search for all transactions with a specific result' do
      transaction = @tr.find_all_by_result("success")

      expect(transaction.class).to eq(Array)
      expect(transaction.sample.result).to eq("success")
    end
  end

  describe '#create' do
    it 'can make a new instance of transaction' do
      highest_trans_id = @tr.repository.sort_by do |transaction|
        transaction.id.to_i
      end.last

      transaction = @tr.create({:invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success"})

      expect(transaction.id > highest_trans_id.id).to be true
      expect(@tr.repository.include?(transaction)).to be true
    end
  end

  describe '#update' do
    it 'can update an existing transation' do
      transaction = @tr.find_by_id(4)
      transaction_time = transaction.updated_at
      @tr.update(4, {:credit_card_number => "1212121212121212", :credit_card_expiration_date => "0925"})
      expect(transaction.credit_card_number).to eq("1212121212121212")
      expect(transaction.updated_at).not_to eq(transaction_time)
    end
  end

  describe '#delete' do
    it 'can remove a transaction from the repository' do
      transaction = @tr.repository.sample
      @tr.delete(transaction.id)
      expect(@tr.repository.include?(transaction)).to be false
    end
  end
end
