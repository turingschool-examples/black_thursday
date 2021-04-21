require 'transaction'
require 'bigdecimal'

RSpec.describe Transaction do
  describe 'instantiation' do
    it '::new' do
      mock_engine = double('TransactionRepo')
      transaction = Transaction.new({:id => 6,
                                     :invoice_id => 8,
                                     :credit_card_number => '4242424242424242',
                                     :credit_card_expiration_date => '0220',
                                     :result => 'success',
                                     :created_at => Time.now,
                                     :updated_at => Time.now}, mock_engine)
     
      expect(transaction).to be_an_instance_of(Transaction)
    end

    it 'has attributes' do
      mock_engine = double('TransactionRepo')
      transaction = Transaction.new({:id => 6,
                                     :invoice_id => 8,
                                     :credit_card_number => '4242424242424242',
                                     :credit_card_expiration_date => '0220',
                                     :result => 'success',
                                     :created_at => Time.now,
                                     :updated_at => Time.now}, mock_engine)

      expect(transaction.id).to eq(6)
      expect(transaction.invoice_id).to eq(8)
      expect(transaction.credit_card_number).to eq('4242424242424242')
      expect(transaction.credit_card_expiration_date).to eq('0220')
      expect(transaction.result).to eq('success')
      expect(transaction.created_at).to be_an_instance_of(Time)
      expect(transaction.updated_at).to be_an_instance_of(Time)
    end

    it '#update credit card number' do
      mock_engine = double('TransactionRepo')
      transaction = Transaction.new({:id => 6,
                                    :invoice_id => 8,
                                    :credit_card_number => '4242424242424242',
                                    :credit_card_expiration_date => '0220',
                                    :result => 'success',
                                    :created_at => Time.now,
                                    :updated_at => Time.now}, mock_engine)

      transaction.update_credit_card_number({:credit_card_number => '565656565656'})

      expect(transaction.credit_card_number).to eq '565656565656'

      transaction.update_credit_card_number({:invoice_id => 12})

      expect(transaction.credit_card_number).to eq '565656565656'
    end

    it '#update credit card expiration date' do
      mock_engine = double('TransactionRepo')
      transaction = Transaction.new({:id => 6,
                                    :invoice_id => 8,
                                    :credit_card_number => '4242424242424242',
                                    :credit_card_expiration_date => '0220',
                                    :result => 'success',
                                    :created_at => Time.now,
                                    :updated_at => Time.now}, mock_engine)

      transaction.update_credit_card_expiration_date({:credit_card_expiration_date => '0321'})

      expect(transaction.credit_card_expiration_date).to eq '0321'

      transaction.update_credit_card_expiration_date({:invoice_id => 12})

      expect(transaction.credit_card_expiration_date).to eq '0321'
    end

    it '#update result' do
      mock_engine = double('TransactionRepo')
      transaction = Transaction.new({:id => 6,
                                    :invoice_id => 8,
                                    :credit_card_number => '4242424242424242',
                                    :credit_card_expiration_date => '0220',
                                    :result => 'success',
                                    :created_at => Time.now,
                                    :updated_at => Time.now}, mock_engine)

      transaction.update_result({:result => 'pending'})

      expect(transaction.result).to eq 'pending'

      transaction.update_result({:invoice_id => 12})

      expect(transaction.result).to eq 'pending'
    end

    it '#update updated at' do
      mock_engine = double('TransactionRepo')
      transaction = Transaction.new({:id => 6,
                                    :invoice_id => 8,
                                    :credit_card_number => '4242424242424242',
                                    :credit_card_expiration_date => '0220',
                                    :result => 'success',
                                    :created_at => Time.now,
                                    :updated_at => Time.now}, mock_engine)
      
      transaction.update_updated_at({:updated_at => Time.now})
    
      expect(transaction.updated_at).to be_an_instance_of(Time)
    end

    it '#updates id' do
      mock_repo = double('ItemRepo')
      transaction = Transaction.new({:id          => 1,
                                     :name        => 'Pencil',
                                     :description => 'You can use it to write things',
                                     :unit_price  => 1099,
                                     :created_at  => Time.now,
                                     :updated_at  => Time.now,
                                     :merchant_id => 2}, mock_repo)  

      new_id = 10000
      transaction.update_id(10000)

      expect(transaction.id).to eq 10001
    end
  end
end
