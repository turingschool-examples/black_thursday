# frozen_string_literal: true

require './lib/transaction'
require './lib/transaction_repository'
require './data/mock_data'


describe TransactionRepository do
  describe '#initialize' do
    it 'exists' do
      data_hashes = [{
        id: 6,
        invoice_id: 8,
        credit_card_number: '4242424242424242',
        credit_card_expiration_date: '0220',
        result: 'success',
        created_at: Time.now,
        updated_at: Time.now
      }]
      mock_data = MockData.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo).is_a? TransactionRepository
    end

    it 'has an array of Transactions' do
      data_hashes = [{
        id: 6,
        invoice_id: 8,
        credit_card_number: '4242424242424242',
        credit_card_expiration_date: '0220',
        result: 'success',
        created_at: Time.now,
        updated_at: Time.now
      }]
      mock_data = MockData.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo).is_a? TransactionRepository
    end
  end
end
