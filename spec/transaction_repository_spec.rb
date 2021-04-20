require 'SimpleCOV'
require 'csv'
require './lib/sales_engine'
require './lib/transaction_repository'

RSpec.describe TransactionRepository do
  describe 'Instance' do
    it 'exists' do
      se = SalesEngine.from_csv(transactions: './data/transactions.csv')
      transaction = se.transactions.find_by_id(6)

      expect(transaction).to be_an_instance_of(Transaction)
    end
    it 'is created with an array of transactions' do
      se = SalesEngine.from_csv(transactions: './data/transactions.csv')

      tr = se.transactions

      expect(tr.all.class).to eq(Array)
      expect(tr.all[0].class).to eq(Transaction)
    end
  end

  describe '#all' do
    it 'returns everything in its array' do
      se = SalesEngine.from_csv(transactions: './data/transactions.csv')

      tr = se.transactions

      expect(tr.all[0].invoice_id).to eq(2179)
    end
  end

  describe '#find_by_id' do
    it 'finds invoice by id' do
      se = SalesEngine.from_csv(transactions: './data/transactions.csv')

      tr = se.transactions

      expect(tr.find_by_id(220).invoice_id).to eq(3155)
    end
  end

  describe '#find_all_by_invoice_id' do
    it 'finds all invoices with passed id' do
      se = SalesEngine.from_csv(
        invoices:     './data/invoices.csv',
        transactions: './data/transactions.csv'
      )

      tr = se.transactions
      expect(tr.find_all_by_invoice_id(8)[0].id).to eq(535)
    end
  end

  describe '#find_all_by_credit_card_number' do
    it 'finds all credit card numbers' do
      se = SalesEngine.from_csv(transactions: './data/transactions.csv')

      tr = se.transactions
      expect(tr.find_all_by_credit_card_number('4035885351912165')[0].id).to eq(14)
    end
  end

  describe '#find_all_by_result' do
    it 'finds all with passed result' do
      se = SalesEngine.from_csv(transactions: './data/transactions.csv')

      tr = se.transactions
      expect(tr.find_all_by_result(:success)[0].id).to eq(1)
    end
  end

  describe '#create' do
    it 'creates a transaction' do
      se = SalesEngine.from_csv(transactions: './data/transactions.csv')

      tr = se.transactions
      actual = {
        invoice_id:                   '8',
        credit_card_number:           '4242424242424242',
        credit_card_expiration_date:  '0220',
        result:                       'success'
      }
      expect(tr.create(actual)).to be_an_instance_of(Transaction)
    end
  end

  describe '#update' do
    it 'updates the given attribute' do
      se = SalesEngine.from_csv(transactions: './data/transactions.csv')

      tr = se.transactions
      tr.update(
        1,
        credit_card_number: '406863194323147',
        credit_card_expiration_date: '0217',
        result: 'success'
      )
      expect(tr.find_by_id(1).result).to eq(:success)
    end
  end

  describe '#delete' do
    it 'deletes a transaction via id' do
      se = SalesEngine.from_csv(transactions: './data/transactions.csv')

      tr = se.transactions

      tr.delete(6)

      expect(tr.find_by_id(6)).to eq(nil)
    end
  end

  describe '#transactions_by_invoice' do
    it 'deletes a transaction via id' do
      se = SalesEngine.from_csv(transactions: './data/transactions.csv')

      tr = se.transactions

      expect(tr.transactions_by_invoice).to eq(nil)
    end
  end
end
