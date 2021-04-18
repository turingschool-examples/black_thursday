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
end
