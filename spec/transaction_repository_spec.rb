# frozen_string_literal: true

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
      expect(@tr.find_by_id(1).created_at).to eq(@tr.find_by_id(1).created_at)
      expect(@tr.find_by_id(-1)).to be nil
    end

    it '#find_by_invoice_id' do
      expect(@tr.find_by_invoice_id(2179)).to be_a Transaction
      expect(@tr.find_by_invoice_id(2179).id).to eq 1
      expect(@tr.find_by_invoice_id(-1)).to be nil
    end

    it '#find_all_by_credit_card_number' do
      txn = @tr.find_by_id(1)
      cc_num = '4068631943231473'

      expect(@tr.find_all_by_credit_card_number(cc_num)).to be_an Array
      expect(@tr.find_all_by_credit_card_number(cc_num)).to include txn
      expect(@tr.find_all_by_credit_card_number(-1)).to eq []
    end

    it '#find_all_by_result' do
      result = 'failed'

      expect(@tr.find_all_by_result(result)).to be_an Array
      expect(@tr.find_all_by_result(result).first.id).to eq 9
    end

    it '#create' do
      data = {
        id: nil,
        invoice_id: '10000',
        credit_card_number: '1111222233334444',
        credit_card_expiration_date: '0721',
        result: 'failed',
        created_at: '2021-07-14 20:56:57 UTC',
        updated_at: '2021-07-14 20:56:57 UTC'
      }
      last_id = @tr.all.last.id
      new_transactions = @tr.create(data)

      expect(new_transactions).to be_an Array
      expect(new_transactions.last.id).to eq(last_id + 1)
    end

    it '#update' do
      time = Time.now
      id = 1
      attributes = {
        id: nil,
        invoice_id: '10000',
        credit_card_number: '1111222233334444',
        credit_card_expiration_date: '0721',
        created_at: '2021-07-14 20:56:57 UTC',
        updated_at: time
      }
      updated_transaction = @tr.update(id, attributes)

      expect(updated_transaction).to be_a Transaction
      expect(updated_transaction.id).to eq 1
      expect(updated_transaction.credit_card_number).to eq '1111222233334444'
      expect(updated_transaction.result).to eq 'success'
      expect(updated_transaction.updated_at).to_not eq time
    end

    it '#delete' do
      deleted = @tr.delete(1)

      expect(deleted).to be_a Transaction
      expect(deleted.id).to eq 1
      expect(@tr.all).to_not include deleted
    end
  end
end
