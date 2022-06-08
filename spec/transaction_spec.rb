require 'csv'
require './lib/transaction'

RSpec.describe Transaction do
  before :each do

        @transaction = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
  end

    it 'exists' do
      expect(@transaction).to be_a Transaction
      expect(@transaction.id).to eq(6)
      expect(@transaction.invoice_id).to eq(8)
      expect(@transaction.credit_card_number).to eq("4242424242424242")
      expect(@transaction.credit_card_expiration_date).to eq("0220")
      expect(@transaction.result).to eq("success")
      expect(@transaction.created_at).to be_a Time
      expect(@transaction.updated_at).to be_a Time
    end
end
