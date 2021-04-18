require_relative '../lib/sales_engine'
require_relative '../lib/transaction_repository'

RSpec.describe TransactionRepository do
  describe 'initialization' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv",
                              :customers => "./data/customers.csv",
                              :invoice_items => "./data/invoice_items.csv",
                              :transactions => "./data/transactions.csv"
                              })
    transaction_repo = sales_engine.transactions

    it 'exists' do
      expect(transaction_repo).to be_instance_of(TransactionRepository)
    end

    it 'can create transaction objects' do
      expect(transaction_repo.array_of_objects[0]).to be_instance_of(Transaction)
    end
  end

  describe 'parent class methods' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv",
                              :customers => "./data/customers.csv",
                              :invoice_items => "./data/invoice_items.csv",
                              :transactions => "./data/transactions.csv"
                              })
    transaction_repo = sales_engine.transactions

    describe '#all' do
      it 'returns array of all transactions' do
        expect(transaction_repo.all.length).to eq(4985)
      end
    end

    it '#find_by_id returns an instance by matching id' do
      id = 50

      expect(transaction_repo.find_by_id(id).id).to eq(id)
      expect(transaction_repo.find_by_id(id).result).to eq(:success)
    end

    describe '#delete' do
      it 'can delete transaction' do
        transaction_repo.delete(50)
        expected = transaction_repo.find_by_id(50)
        expect(expected).to eq(nil)
      end
    end
  end


end
