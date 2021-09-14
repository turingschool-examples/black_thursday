require './lib/transaction'
require './lib/transaction_repository'

RSpec.describe TransactionRepository do

  before :each do
    path = './data/transactions.csv'
    @tr = TransactionRepository.new(path)
  end

  context 'Instantiation' do
    it 'exists' do
      expect(@tr).to be_a TransactionRepository
    end
  end

  context 'Methods' do
    it '#all' do
      expect(@tr.all).to be_an Array
      expect(@tr.all.count).to eq 4985
    end

    it '#find_by_id' do
      expect(@tr.find_by_id(1)).to be_a Transaction
      expect(@tr.find_by_id(1).created_at).to eq '2012-02-26 20:56:56 UTC'
      expect(@tr.find_by_id(-1)).to be nil
    end

    it '#find_by_invoice_id' do
      expect(@tr.find_by_invoice_id(2179)).to be_a Transaction
      expect(@tr.find_by_invoice_id(2179).id).to eq 1
      expect(@tr.find_by_invoice_id(-1)).to be nil
    end

    it '#find_by_credit_card_number' do
      transaction = @tr.find_by_id(1)

      expect(@tr.find_by_credit_card_number('4068631943231473')).to be_an Array
      expect(@tr.find_by_credit_card_number('4068631943231473')).to include transaction
      expect(@tr.find_by_credit_card_number(-1)).to eq []
    end
  end
end
