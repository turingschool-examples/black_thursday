require './spec/spec_helper'
require './lib/transaction_repository'

RSpec.describe TransactionRepository do 
  
  describe '#initialize' do 
    let (:transaction) {Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
  })}
    it 'will exist and have attributes' do 
      expect(transaction_repository).to be_a()
    end
  end
end