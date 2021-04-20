require './data/transaction_mocks'

RSpec.describe TransactionMocks do
  describe '#transions_as_hashes' do
    it 'returns mock data for transactions' do
      tas_as_hashes = TransactionMocks.transactions_as_hashes

      expect(tas_as_hashes).to be_an Array
      expect(tas_as_hashes.length).to eq 10
      expect(tas_as_hashes.first).to be_a Hash
    end

    it 'generates expected attributes' do
      tas_as_hashes = TransactionMocks.transactions_as_hashes

      expect(tas_as_hashes).to be_an Array
      tas_as_hashes.each do |ta_hash|
        expect(ta_hash[:id]).to be_an Integer
        expect(ta_hash[:credit_card_number]).to be_a String
        expect(ta_hash[:credit_card_expiration_date]).to be_a String
        expect(ta_hash[:result]).to be_a String
        expect(ta_hash[:created_at]).to match InvoiceMocks.date_format
        expect(ta_hash[:updated_at]).to match InvoiceMocks.date_format
      end
    end

    it 'returns custom number of mocked hashes' do
      tas_as_hashes = TransactionMocks.transactions_as_hashes(number_of_hashes: 3)

      expect(tas_as_hashes.length).to eq 3
    end

    it 'returns mocks with custom invoice_id_range' do
      tas_as_hashes = TransactionMocks.transactions_as_hashes(invoice_id: 1)

      tas_as_hashes.each do |ta_hash|
        expect(ta_hash[:invoice_id]).to eq 1
      end
    end

    it 'returns mocks with non-random credit card nums' do
      tas_as_hashes = TransactionMocks.transactions_as_hashes(credit_card_number: '4068631943231473')

      tas_as_hashes.each do |ta_hash|
        expect(ta_hash[:credit_card_number]).to eq '4068631943231473'
      end
    end

    it 'returns custom exiration dates' do
      tas_as_hashes = TransactionMocks.transactions_as_hashes(credit_card_expiration_date: '0217')

      tas_as_hashes.each do |ta_hash|
        expect(ta_hash[:credit_card_expiration_date]).to eq '0217'
      end
    end

    it 'returns custom result' do
      tas_as_hashes = TransactionMocks.transactions_as_hashes(result: 'failed')

      tas_as_hashes.each do |ta_hash|
        expect(ta_hash[:result]).to eq 'failed'
      end
    end

    it 'returns non-random time stamps' do
      tas_as_hashes = TransactionMocks.transactions_as_hashes(random_dates: false)
      tas_as_hashes.each do |ta_hash|
        expect(ta_hash[:created_at]).to eq '2021-01-01'
      end
    end
  end

  describe '#transactions_as_mocks' do
    it 'returns mock data of transactions' do
      transactions_as_mocks = TransactionMocks.transactions_as_mocks(self)

      expect(transactions_as_mocks).to be_an Array
      transactions_as_mocks.each do |ta_mock|
        expect(ta_mock.id).to be_an Integer
        expect(ta_mock.invoice_id).to be_an Integer
        expect(ta_mock.credit_card_number).to be_a String
        expect(ta_mock.credit_card_expiration_date).to be_a String
        expect(ta_mock.result).to be_a String
        expect(ta_mock.created_at).to match InvoiceMocks.date_format
        expect(ta_mock.updated_at).to match InvoiceMocks.date_format
      end
    end
    it 'accepts custom hashes' do
      transaction_hashes = TransactionMocks.transactions_as_hashes(number_of_hashes: 2)
      transaction_mocks = TransactionMocks.transactions_as_mocks(self, transaction_hashes)
      expect(transaction_mocks.length).to eq 2
    end
  end
end
