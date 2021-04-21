require 'CSV'
require 'transaction_repo'
require 'sales_engine'

RSpec.describe TransactionRepo do
  describe 'instantiation' do
    it '::new' do
      mock_engine = double('TransactionRepo')
      transaction_repo = TransactionRepo.new('./fixtures/mock_transactions.csv', mock_engine)

      expect(transaction_repo).to be_an_instance_of(TransactionRepo)
    end

    it 'has attributes' do
      mock_engine = double('TransactionRepo')
      transaction_repo = TransactionRepo.new('./fixtures/mock_transactions.csv', mock_engine)

      expect(transaction_repo.transactions).to be_an_instance_of(Array)
    end
  end

  describe '#methods' do
    it '#all' do
      mock_engine = double('TransactionRepo')
      transaction_repo = TransactionRepo.new('./fixtures/mock_transactions.csv', mock_engine)

      expect(transaction_repo.all).to be_an_instance_of(Array)
    end

    it '#find by id' do
      mock_engine = double('TransactionRepo')
      transaction_repo = TransactionRepo.new('./fixtures/mock_transactions.csv', mock_engine)
      collection = transaction_repo.transactions
      transaction = transaction_repo.create({:id => 6,
                                      :invoice_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })


      expect(transaction_repo.find_by_id(transaction.id, collection)).to eq(transaction)
      expect(transaction_repo.find_by_id(999999999, collection)).to eq(nil)
    end

    it'#find all by invoice id' do
      mock_engine = double('TransactionRepo')
      transaction_repo = TransactionRepo.new('./fixtures/mock_transactions.csv', mock_engine)
      collection = transaction_repo.transactions
      transaction = transaction_repo.create({:id => 6,
                                      :invoice_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })

      expect(transaction_repo.find_all_by_invoice_id(transaction.invoice_id, collection)).to eq([transaction])
      expect(transaction_repo.find_all_by_invoice_id(999999999, collection)).to eq([])
    end

    it'#find all by credit card number' do
      mock_engine = double('TransactionRepo')
      transaction_repo = TransactionRepo.new('./fixtures/mock_transactions.csv', mock_engine)
      collection = transaction_repo.transactions
      transaction = transaction_repo.create({:id => 6,
                                      :invoice_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })

      expect(transaction_repo.find_all_by_credit_card_number("4242424242424242", collection)).to eq([transaction])
      expect(transaction_repo.find_all_by_credit_card_number("0000000000000000", collection)).to eq([])
    end


    it'#find all by result' do
      mock_engine = double('TransactionRepo')
      transaction_repo = TransactionRepo.new('./fixtures/mock_transactions.csv', mock_engine)
      collection = transaction_repo.transactions
      transaction = transaction_repo.create({:id => 6,
                                      :invoice_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "sweet success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })

      expect(transaction_repo.find_all_by_result("sweet success", collection)).to eq([transaction])
      expect(transaction_repo.find_all_by_result("sweetsuccess", collection)).to eq([])
    end


    it'#creates a new transaction instance' do
      mock_engine = double('TransactionRepo')
      transaction_repo = TransactionRepo.new('./fixtures/mock_transactions.csv', mock_engine)
      attributes = {:id => 6,
                    :invoice_id => 8,
                    :credit_card_number => "4242424242424242",
                    :credit_card_expiration_date => "0220",
                    :result => "success",
                    :created_at => Time.now,
                    :updated_at => Time.now
                  }

      transaction_repo.all

      expect(transaction_repo.create(attributes)).to be_an_instance_of(Transaction)
    end


    it '#updates attributes' do
      mock_engine = double('TransactionRepo')
      transaction_repo = TransactionRepo.new('./fixtures/mock_transactions.csv', mock_engine)
      transaction =  transaction_repo.create({:id => 9,
                                              :invoice_id => 8,
                                              :credit_card_number => '4242424242424242',
                                              :credit_card_expiration_date => '0220',
                                              :result => "success",
                                              :created_at => Time.now,
                                              :updated_at => Time.now })

      updated_attributes = {:credit_card_number => '9999999999999999',
                            :credit_card_expiration_date => '0930',
                            :result => 'sweet success',
                            :updated_at  => Time.now}

      transaction_repo.update(transaction.id, updated_attributes)

      expect(transaction.id).to eq(10)
      expect(transaction.credit_card_number).to eq('9999999999999999')
      expect(transaction.credit_card_expiration_date).to eq('0930')
      expect(transaction.result).to eq("sweet success")
      expect(transaction.updated_at).to be_an_instance_of(Time)
    end

   it '#deletes by id' do
     mock_engine = double('TransactionRepo')
     transaction_repo = TransactionRepo.new('./fixtures/mock_transactions.csv', mock_engine)
     transaction = transaction_repo.create({:id => 6,
                                            :invoice_id => 8,
                                            :credit_card_number => "4242424242424242",
                                            :credit_card_expiration_date => "0220",
                                            :result => "success",
                                            :created_at => Time.now,
                                            :updated_at => Time.now})

      expect(transaction_repo.all.length).to eq(10)

      transaction_repo.delete(transaction.id)

      expect(transaction_repo.all.length).to eq(9)
    end

    it '#invoice paid in full?' do
    sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                         :merchants => './fixtures/mock_merchants.csv',
                                         :invoices => './fixtures/mock_invoices.csv',
                                         :invoice_items => './fixtures/mock_invoice_items.csv',
                                         :transactions  => './fixtures/mock_transactions.csv',
                                         :customers => './fixtures/mock_customers.csv'})
      
      transaction_repo = sales_engine.transactions
   
      expect(transaction_repo.invoice_paid_in_full?(2179)).to eq(true)
      expect(transaction_repo.invoice_paid_in_full?(2)).to eq(false)
    end
  end
end
