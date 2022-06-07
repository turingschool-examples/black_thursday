require './lib/transaction_repository'

RSpec.describe TransactionRepository do
  before :each do
    @filepath = './data/transactions.csv'
    @collection = TransactionRepository.new(@filepath)
    @attributes = {
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at  => '1994-05-07 23:38:43 UTC',
      :updated_at  => '2016-01-11 11:30:35 UTC',
    }
  end

  describe '#initialize' do
    it 'is an TransactionRepository' do
      expect(@collection).to be_a TransactionRepository
    end

    it 'can return an array of all known Transaction instances' do
      expect(@collection.all).to be_a Array
      expect(@collection.all.count).to eq 4985
      expect(@collection.all.first).to be_a Transaction
      expect(@collection.all.first.id).to eq 1
    end
  end

  describe '#find_by_id' do
    it 'returns nil if no transaction has the searched id' do
      expect(@collection.find_by_id(2813308004)).to eq nil
    end

    it 'can return an transaction with a matching id' do
      expect(@collection.find_by_id(1)).to be_a Transaction
      expect(@collection.find_by_id(1).invoice_id).to eq 2179
    end
  end

  describe '#find_all_by_invoice_id' do
    it 'returns an empty array if no transactions have matching invoice id' do
      expect(@collection.find_all_by_invoice_id(2813308004)).to eq []
    end

    it 'returns an array if transactions have matching invoice id' do
      expect(@collection.find_all_by_invoice_id(1).count).to eq 2
      expect(@collection.find_all_by_invoice_id(2).count).to eq 2
    end
  end

  describe '#find_all_by_credit_card_number' do
    it 'returns an empty array if no transactions have matching credit card number' do
      expect(@collection.find_all_by_credit_card_number('2813308004')).to eq []
    end

    it 'returns an array if transactions have matching credit card number' do
      expect(@collection.find_all_by_credit_card_number('4068631943231473').count).to eq 1
      expect(@collection.find_all_by_credit_card_number('4426959354436260').count).to eq 1
    end
  end

  describe '#find_all_by_result' do
    it 'returns an empty array if no transactions have matching result' do
      expect(@collection.find_all_by_result('in the void')).to eq []
    end

    it 'returns an array if transactions have matching result' do
      expect(@collection.find_all_by_result('success').count).to eq 4158
      expect(@collection.find_all_by_result('failed').count).to eq 827
    end
  end

  describe '#create' do
    it 'can create a new transaction with provided attributes' do
      expect(@collection.find_by_id(4986)).to eq nil
      @collection.create(@attributes)
      expect(@collection.find_by_id(4986)).to be_a Transaction
      expect(@collection.find_by_id(4986).invoice_id).to eq 8
      expect(@collection.find_by_id(4986).credit_card_number).to eq '4242424242424242'
      expect(@collection.find_by_id(4986).credit_card_expiration_date).to eq '0220'
      expect(@collection.find_by_id(4986).result).to eq 'success'
      expect(@collection.find_by_id(4986).created_at).to eq '1994-05-07 23:38:43 UTC'
      expect(@collection.find_by_id(4986).updated_at).to eq '2016-01-11 11:30:35 UTC'
    end
  end

  describe '#update' do
    it 'can update the result of an transaction' do
      expect(@collection.find_by_id(4980).result).to eq 'failed'
      @collection.update(4980, '1234567890', '0923', 'success')
      expect(@collection.find_by_id(4980).credit_card_number).to eq '1234567890'
      expect(@collection.find_by_id(4980).credit_card_expiration_date).to eq '0923'
      expect(@collection.find_by_id(4980).result).to eq 'success'
      expect(@collection.find_by_id(4980).updated_at).not_to eq '2014-03-15'
    end
  end

  describe '#delete' do
    it 'can delete an transaction based on id' do
      expect(@collection.find_by_id(1).result).to eq 'success'
      @collection.delete(1)
      expect(@collection.find_by_id(1)).to eq nil
    end
  end
end
