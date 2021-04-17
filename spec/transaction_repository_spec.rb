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

  describe '#find_by_id' do
    it 'returns nil if no Transaction has id specified' do
      mock_data = MockData.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.find_by_id(10)).to eq nil
    end

    it 'returns first Transaction with id specified' do
      mock_data = MockData.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.find_by_id(6)).to eq t_repo.transactions.first
    end
  end

  describe '#find_all_by_invoice_id' do
    it 'returns empty array if no Transactions have invoice_id specified' do
      mock_data = MockData.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.find_all_by_invoice_id(10)).to eq []
    end

    it 'returns all Transactions with invoice_id specified' do
      mock_data = MockData.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.find_all_by_invoice_id(8).length).to eq 10
    end
  end

  describe '#find_all_by_credit_card_number' do
    it 'returns empty array if no Transactions have specified cc number' do
      mock_data = MockData.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.find_all_by_credit_card_number('1212121212121212')).to eq []
    end

    it 'returns all Transactions with specified cc number' do
      mock_data = MockData.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      all_for_cc_number = t_repo.find_all_by_credit_card_number('4242424242424242')
      expect(all_for_cc_number.length).to eq 10
    end
  end
end
