# frozen_string_literal: true

require './lib/transaction'
require './lib/transaction_repository'
require './data/mock_data'


describe TransactionRepository do
  details = {
    id: 6,
    invoice_id: 8,
    credit_card_number: '4242424242424242',
    credit_card_expiration_date: '0220',
    result: 'success',
    created_at: Time.now,
    updated_at: Time.now
  }
  data_hashes = []
  10.times { data_hashes <<  details }

  describe '#initialize' do
    it 'exists' do
      mock_data = MockData.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo).is_a? TransactionRepository
    end

    it 'has an array of Transactions' do
      mock_data = MockData.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.transactions).is_a? Array
    end
  end

  describe '#all' do
    it 'returns a list of all Transactions' do
      mock_data = MockData.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.all.length).to eq 10
    end
  end
end
