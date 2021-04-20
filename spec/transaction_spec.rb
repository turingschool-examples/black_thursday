require 'rspec'
require './lib/transaction'
require './lib/sales_engine'
RSpec.describe Transaction do
  se = SalesEngine.from_csv({
  :transactions => "./data/transactions.csv"
  })
  transaction_repo = se.transactions
  context "Transaction" do
    it "exists" do
      expect(transaction_repo.transaction_list[0]).to be_instance_of(Transaction)
    end
  end
  context 'attr_accessor' do
    it 'can return id' do
      expect(transaction_repo.transaction_list[0].id).to eq(1)
    end
    it 'can return transaction id' do
      expect(transaction_repo.transaction_list[0].invoice_id).to eq(2179)
    end
    it 'can return a credit card number' do
      expect(transaction_repo.transaction_list[0].credit_card_number).to eq("4068631943231473")
    end
    it 'can return a credit card expiration date' do
      expect(transaction_repo.transaction_list[0].credit_card_expiration_date).to eq("0217")
    end
    it 'can return a result' do
      expect(transaction_repo.transaction_list[0].result).to eq(:success)
    end
    it 'can return time created at' do
      expect(transaction_repo.transaction_list[0].created_at).to eq(Time.parse("2012-02-26 20:56:56.000000000 +0000"))
    end
    it 'can return time updated at' do
      expect(transaction_repo.transaction_list[0].updated_at).to eq(Time.parse("2012-02-26 20:56:56.000000000 +0000"))
    end
  end
end
