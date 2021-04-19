require 'rspec'
require 'bigdecimal'
require 'time'
require './lib/sales_engine'
require './lib/transaction'
require './lib/transaction_repo'
RSpec.describe TransactionRepo do
  se = SalesEngine.from_csv({
  :transactions => "./data/transactions.csv"
  })
  transaction_repo = se.transactions
  context 'it exists' do
    it 'exists' do
      expect(transaction_repo).to be_instance_of(TransactionRepo)
    end
  end
  context 'methods' do
    it 'can return all items' do
      expect(transaction_repo.all.class).to eq(Array)
      expect(transaction_repo.all.length).to eq(4985)
    end

    it "can find invoice by id" do
      expect(transaction_repo.find_by_id(1)).to be_instance_of(Transaction)
      expect(transaction_repo.find_by_id(10000)).to eq(nil)
      expect(transaction_repo.find_by_id(1)).to eq(transaction_repo.transaction_list[0])
    end

    # it 'can find all by credit_card_number' do
    #   expect(invoice_repository.find_all_by_credit_card_number(1).class).to eq(Array)
    #   expect(invoice_repository.find_all_by_credit_card_number(4068631943231473).length).to eq(1)
    #   expect(invoice_repository.find_all_by_credit_card_number(1).first).to eq(transaction_repo.transaction_list[0])
    #   expect(invoice_repository.find_all_by_credit_card_number(9999999)).to eq([])
    # end
  end
end
