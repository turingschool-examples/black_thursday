require './data/mockable'
require './lib/transaction'
require './lib/transaction_repository'

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
  10.times { data_hashes << details }

  describe '#initialize' do
    it 'exists' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo).is_a? TransactionRepository
    end

    it 'has an array of Transactions' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.transactions).is_a? Array
    end
  end

  describe '#all' do
    it 'returns a list of all Transactions' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.all.length).to eq 10
    end
  end

  describe '#find_by_id' do
    it 'returns nil if no Transaction has id specified' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.find_by_id(10)).to eq nil
    end

    it 'returns first Transaction with id specified' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.find_by_id(6)).to eq t_repo.transactions.first
    end
  end

  describe '#find_all_by_invoice_id' do
    it 'returns empty array if no Transactions have invoice_id specified' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.find_all_by_invoice_id(10)).to eq []
    end

    it 'returns all Transactions with invoice_id specified' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.find_all_by_invoice_id(8).length).to eq 10
    end
  end

  describe '#find_all_by_credit_card_number' do
    it 'returns empty array if no Transactions have specified cc number' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.find_all_by_credit_card_number('1212121212121212')).to eq []
    end

    it 'returns all Transactions with specified cc number' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      all_for_cc_number = t_repo.find_all_by_credit_card_number('4242424242424242')
      expect(all_for_cc_number.length).to eq 10
    end
  end

  describe '#find_all_by_result' do
    it 'return empty array if no Transactions with matching status' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.find_all_by_result('failure')).to eq []
    end

    it 'returns all Transactions with matching status' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.find_all_by_result('success').length).to eq 10
    end
  end

  describe '#create' do
    it 'creates a Transaction' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      attributes = {
        id: nil,
        invoice_id: 8,
        credit_card_number: '1212121212121212',
        credit_card_expiration_date: '0222',
        result: 'success',
        created_at: Time.now,
        updated_at: Time.now
      }
      new_transactions = t_repo.create(attributes)

      expect(new_transactions.last).is_a? Transaction
      expect(new_transactions.last.id).to eq 7
      expect(new_transactions.length).to eq 11
    end
  end

  describe '#update' do
    it 'updates the correct Transaction and attributes' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      attributes = {
        id: nil,
        invoice_id: 8,
        credit_card_number: '1212121212121212',
        credit_card_expiration_date: '0222',
        result: 'failure',
        created_at: Time.now,
        updated_at: Time.now
      }
      new_transactions = t_repo.create(attributes)
      new_info = {
        credit_card_number: '1212121212124444',
        credit_card_expiration_date: '0224',
        result: 'success'
      }
      t_repo.update(7, new_info)
      updated_item = t_repo.find_by_id(7)

      expect(updated_item.credit_card_number).to eq '1212121212124444'
      expect(updated_item.credit_card_expiration_date).to eq '0224'
      expect(updated_item.result).to eq 'success'
    end

    it 'does not update immutable attributes' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      attributes = {
        id: nil,
        invoice_id: 8,
        credit_card_number: '1212121212121212',
        credit_card_expiration_date: '0222',
        result: 'failure',
        created_at: Time.new(2021, 0o3, 0o1),
        updated_at: Time.new(2021, 0o3, 0o1)
      }
      new_transactions = t_repo.create(attributes)
      new_info = {
        id: 10,
        invoice_id: 12,
        credit_card_number: '1212121212124444',
        credit_card_expiration_date: '0224',
        result: 'success',
        created_at: Time.new(2021, 0o2, 0o4),
        updated_at: Time.new(2021, 0o2, 0o4)
      }
      t_repo.update(7, new_info)
      updated_item = t_repo.transactions.last

      expect(updated_item.id).to eq 7
      expect(updated_item.invoice_id).to eq 8
      expect(updated_item.created_at).to eq Time.new(2021, 0o3, 0o1)
      expect(updated_item.updated_at).to be > Time.new(2021, 0o3, 0o1)
    end
  end

  describe '#delete' do
    it 'deletes the object at specified id' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      attributes = {
        id: nil,
        invoice_id: 8,
        credit_card_number: '1212121212121212',
        credit_card_expiration_date: '0222',
        result: 'failure',
        created_at: Time.new(2021, 0o3, 0o1),
        updated_at: Time.new(2021, 0o3, 0o1)
      }
      new_transactions = t_repo.create(attributes)

      expect(t_repo.transactions.length).to eq 11

      t_repo.delete(7)

      expect(t_repo.transactions.length).to eq 10
    end

    it 'does not delete anything if no item at id' do
      mock_data = Mockable.mock_generator(self, 'Transaction', data_hashes)
      allow_any_instance_of(TransactionRepository).to receive(:create_transactions).and_return(mock_data)
      t_repo = TransactionRepository.new('fake.csv')

      expect(t_repo.transactions.length).to eq 10

      t_repo.delete(7)

      expect(t_repo.transactions.length).to eq 10
    end
  end
end
