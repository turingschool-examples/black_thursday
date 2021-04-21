require 'CSV'
require './lib/sales_engine'
require './lib/transaction_repo'
require './lib/transaction'
require './lib/invoice_repo'
require './lib/invoice'
require './lib/invoice_item_repo'
require './lib/invoice_item'

RSpec.describe TransactionRepo do
  before(:each) do
    @sales_engine = SalesEngine.from_csv({:items => './data/items.csv',
                                          :merchants => './data/merchants.csv',
                                          :invoices => './data/invoices.csv',
                                          :invoice_items => './data/invoice_items.csv',
                                          :transactions  => './data/transactions.csv',
                                          :customers => './data/customers.csv'
                                        })
  end

  describe 'instantiation' do
    it '::new' do
      transaction_repo = @sales_engine.transactions

      expect(transaction_repo).to be_an_instance_of(TransactionRepo)
    end

    it 'has attributes' do
      transaction_repo = @sales_engine.transactions

      expect(transaction_repo.transactions).to be_an_instance_of(Array)
    end
  end

  describe '#methods' do

    it '#all' do
      transaction_repo = @sales_engine.transactions

      expect(transaction_repo.all).to be_an_instance_of(Array)
    end

    it '#find by id' do
      transaction_repo = @sales_engine.transactions
      transaction1 = transaction_repo.create({:id => 6,
                                      :invoice_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })


      expect(transaction_repo.find_by_id(transaction1.id)).to eq(transaction1)
      expect(transaction_repo.find_by_id(999999999)).to eq(nil)
    end

    it '#find all by invoice id' do
      transaction_repo = @sales_engine.transactions
      transaction1 = transaction_repo.create({:id => 6,
                                      :invoice_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })

      # transaction_repo.add_transaction(transaction1)

      expect(transaction_repo.find_all_by_invoice_id(transaction1.id)).to eq([transaction])
      # expect(transaction_repo.find_all_by_invoice_id).to eq([transaction1])
      expect(transaction_repo.find_all_by_invoice_id(0)).to eq([])
    end

    xit '#find all by credit card number' do
      transaction_repo = @sales_engine.transactions
      transaction1 = transaction_repo.create({:id => 6,
                                      :invoice_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })

      transaction_repo.add_transaction(transaction1)

      expect(transaction1.find_all_by_credit_card_number("4242424242424242")).to eq([transaction1])
      expect(transaction1.find_all_by_credit_card_number("0000000000000000")).to eq([])
    end

    it '#find all by result' do
      transaction_repo = @sales_engine.transactions
      transaction1 = Transaction.create({:id => 6,
                                      :invoice_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })

      transaction_repo.add_transaction(transaction1)

      expect(transaction1.find_all_by_result("success")).to eq([transaction1])
      expect(transaction1.find_all_by_result("sweet success")).to eq([])
    end

    it '#creates a new transaction instance' do
      transaction_repo = @sales_engine.transactions
      transaction1 = Transaction.create({:id => 6,
                                      :invoice_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })

      transaction_repo.all

      expect(transaction_repo.create(transaction1)).to be_an_instance_of(Transaction)
    end

    it '#updates attributes' do
      transaction_repo = @sales_engine.transactions
      transaction1 = Transaction.create({:id => 6,
                                      :invoice_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })
      transaction_repo.add_transaction(transaction1)

      updated_attributes = {:credit_card_number => "9999999999999999",
                            :credit_card_expiration_date => "0930",
                            :result => "sweet success",
                            :updated_at  => Time.now
                            }

      transaction_repo.update(6, updated_attributes)

      expect(transaction1.id).to eq(6)
      expect(transaction1.credit_card_number).to eq("9999999999999999")
      expect(transaction1.credit_card_expiration_date).to eq("0930")
      expect(transaction1.result).to eq("sweet success")
      expect(transaction1.updated_at).to be_an_instance_of(Time)
    end

    it '#deletes by id' do
      transaction_repo = @sales_engine.transactions
      transaction1 = Transaction.create({:id => 6,
                                      :invoice_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })
      transaction_repo.add_transaction(transaction1)

      expect(transaction_repo.find_by_id(6)).to eq(transaction1)

      transaction_repo.delete(6)

      expect(transaction_repo.find_by_id(6)).to eq(nil)
    end
  end
end
