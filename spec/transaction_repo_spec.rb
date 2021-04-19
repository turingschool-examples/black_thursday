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

    it "can find invoice by id" do
      expect(transaction_repo.find_all_by_invoice_id(10000)).to eq([])
      expect(transaction_repo.find_all_by_invoice_id(2179).length).to eq(2)
    end

    it "can find all by credit_card_number" do
      expect(transaction_repo.find_all_by_credit_card_number(4068631943231473).class).to eq(Array)
      expect(transaction_repo.find_all_by_credit_card_number(4068631943231473).length).to eq(1)
      expect(transaction_repo.find_all_by_credit_card_number(4068631943231473).first).to eq(transaction_repo.transaction_list[0])
      expect(transaction_repo.find_all_by_credit_card_number(9999999)).to eq([])
    end

    it "can find all by result" do
      expect(transaction_repo.find_all_by_result("success").class).to eq(Array)
      expect(transaction_repo.find_all_by_result("failed").length).to eq(827)
    end

    it "can create" do
      attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      }

      transaction_repo.create(attributes)
      expected = transaction_repo.find_by_id(4986)
      expect(expected.class).to eq(Transaction)
      expect(expected.invoice_id).to eq(8)
      expect(expected.credit_card_number).to eq(4242424242424242)
      expect(expected.credit_card_expiration_date).to eq(220)
      expect(expected.result).to eq("success")
    end
  end
end
