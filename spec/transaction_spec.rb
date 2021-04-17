require './lib/transaction'
require 'bigdecimal'

RSpec.describe Transaction do
  describe 'instantiation' do
    it '::new' do
      transaction1 = Transaction.new({:id => 6,
                                      :transaction_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })

      expect(transaction1).to be_an_instance_of(Transaction)
    end

    xit 'has attributes' do
      transaction1 = Transaction.new({:id => 6,
                                      :transaction_id => 8,
                                      :credit_card_number => "4242424242424242",
                                      :credit_card_expiration_date => "0220",
                                      :result => "success",
                                      :created_at => Time.now,
                                      :updated_at => Time.now
                                    })

      expect(transaction1.id).to eq(6)
      expect(transaction1.transaction_id).to eq(8)
      expect(transaction1.credit_card_number).to eq("4242424242424242")
      expect(transaction1.credit_card_expiration_date).to eq("0220")
      expect(transaction1.result).to eq("success")
      expect(transaction1.created_at).to be_an_instance_of(Time)
      expect(transaction1.updated_at).to be_an_instance_of(Time)
    end

  end
end
