require_relative '../lib/sales_engine'
require_relative '../lib/transaction'

RSpec.describe Transaction do

  describe '#initialize' do

    transaction = Transaction.new({
                                    :id => 6,
                                    :invoice_id => 8,
                                    :credit_card_number => "4242424242424242",
                                    :credit_card_expiration_date => "0220",
                                    :result => "success",
                                    :created_at => Time.now,
                                    :updated_at => Time.now
                                  })
    it 'exists' do
      expect(transaction).to be_instance_of(Transaction)
    end

    it 'has attributes accessible' do

      expect(transaction.id).to eq(6)
      expect(transaction.invoice_id).to eq(8)
      expect(transaction.credit_card_number).to eq("4242424242424242")
      expect(transaction.credit_card_expiration_date).to eq("0220")
      expect(transaction.result).to eq(:success)
      expect(transaction.created_at.class).to eq(Time)
      expect(transaction.updated_at.class).to eq(Time)
    end
  end

  describe '#time_check' do
    transaction = Transaction.new({
                                    :id => 6,
                                    :invoice_id => 8,
                                    :credit_card_number => "4242424242424242",
                                    :credit_card_expiration_date => "0220",
                                    :result => "success",
                                    :created_at => Time.now,
                                    :updated_at => Time.now
                                  })

    it 'returns input as originally passed in if input is class Time' do
      time_object = Time.parse("2007-06-04 21:35:10 UTC")
      expect(transaction.time_check(time_object)).to eq(time_object)
    end
  end

end
