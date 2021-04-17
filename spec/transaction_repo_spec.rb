require 'CSV'
require './lib/sales_engine'
require './lib/merchant_repo'
require './lib/merchant'
require './lib/item'
require './lib/item_repo'
# require './lib/invoice_item'
# require './lib/invoice_item_repo'
require './lib/transaction'
require 'bigdecimal'

RSpec.describe ItemRepo do
  describe 'instantiation' do
    before(:each) do
      # @repo = SalesEngine.from_csv({:items => "./data/items.csv",
      #                               :merchants => "./data/merchants.csv"})
      @repo = SalesEngine.from_csv(:transactions => "./data/transactions.csv")
    end

    it '::new' do
      transaction_repo = TransactionRepo.new("./data/transactions.csv", @repo)

      expect(transaction_repo).to be_an_instance_of(TransactionRepo)
    end

    it 'has attributes' do
      transaction_repo = TransactionRepo.new("./data/transactions.csv", @repo)

      expect(transaction_repo.transactions).to be_an_instance_of(Array)
    end
  end

  describe '#methods' do

    it '#all' do
      transaction_repo = TransactionRepo.new("./data/transactions.csv", @repo)

      expect(transaction_repo.all).to be_an_instance_of(Array)
    end

    it '#find by id' do
      transaction_repo = TransactionRepo.new("./data/transactions.csv", @repo)
      transaction1 = Transaction.new({:id => 6,
                                      :invoice_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })

      # item_repo.add_item(item1)

      expect(transaction1.find_by_id(6)).to eq(transaction1)
      expect(transaction1.find_by_id(999999999)).to eq(nil)
    end

    it '#find all by invoice id' do
      transaction_repo = TransactionRepo.new("./data/transactions.csv", @repo)
      transaction1 = Transaction.new({:id => 6,
                                      :invoice_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })

      #SOMETHING LIKE transaction_repo.add_invoice(invoice1)

      expect(transaction1.find_all_by_invoice_id(8)).to eq([transaction1])
      expect(transaction1.find_all_by_invoice_id(0)).to eq([])
    end

    it '#find all by credit card number' do
      transaction_repo = TransactionRepo.new("./data/transactions.csv", @repo)
      transaction1 = Transaction.new({:id => 6,
                                      :invoice_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })

      #SOMETHING LIKE transaction_repo.add_invoice(invoice1)

      expect(transaction1.find_all_by_credit_card_number("4242424242424242")).to eq([transaction1])
      expect(transaction1.find_all_by_credit_card_number("0000000000000000")).to eq([])
    end

  end

end
