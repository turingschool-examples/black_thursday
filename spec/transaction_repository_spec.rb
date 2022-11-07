require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

RSpec.describe TransactionRepository do
  let(:transaction_repository) { TransactionRepository.new }

  let(:t_1) { Transaction.new({ :id => 6,
                                :invoice_id => 8,
                                :credit_card_number => "4242424242424242",
                                :credit_card_expiration_date => "0220",
                                :result => "success",
                                :created_at => Time.now,
                                :updated_at => Time.now
                              }) }
  let(:t_2) { Transaction.new({ :id => 1, 
                              :invoice_id => 2,
                              :credit_card_number => "4242424242424243",
                              :credit_card_expiration_date => "0221",
                              :result => "failed",
                              :created_at => Time.now,
                              :updated_at => Time.now
                            }) }  

  describe '#initialize' do
    it 'exist' do
      expect(transaction_repository).to be_a(TransactionRepository)
    end
  end          
  
  describe 'all' do
    it 'starts as an empty array' do
      expect(transaction_repository.all).to eq([])
    end
  end

end

                              