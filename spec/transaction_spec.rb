require_relative 'spec_helper'

RSpec.describe Transaction do
  before :each do
    @mock_repo = double('TransactionRepository')
    @transaction_data = ({
                :id => 6,
                :invoice_id => 8,
                :credit_card_number => "4242424242424242",
                :credit_card_expiration_date => "0220",
                :result => "success",
                :created_at => Time.now,
                :updated_at => Time.now
              })

    @transaction = Transaction.new(@transaction_data, @mock_repo)
  end

  describe 'instantiation' do
    it 'exists' do
      expect(@transaction).to be_a(Transaction)
    end

    it 'has attributes' do
      expect(@transaction_data).to be_a(Hash)
      expect(@transaction.id).to eq(6)
      expect(@transaction.invoice_id).to eq(8)
      expect(@transaction.credit_card_number).to eq("4242424242424242")
      expect(@transaction.credit_card_expiration_date).to eq("0220")
      expect(@transaction.result).to eq("success")
      expect(@transaction.created_at).to be_a(Time)
      expect(@transaction.updated_at).to be_a(Time)
    end
  end

  describe 'methods' do
    it 'can create a new id' do

      @transaction.new_id(11)
      expect(@transaction.id).to eq(11)
    end
  end
end
