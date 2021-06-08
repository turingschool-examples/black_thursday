require_relative 'spec_helper'

RSpec.describe Transaction do
  before :each do
    @t_data = ({
                :id => 6,
                :invoice_id => 8,
                :credit_card_number => "4242424242424242",
                :credit_card_expiration_date => "0220",
                :result => "success",
                :created_at => Time.now,
                :updated_at => Time.now
              })

    @transaction = Transaction.new(@t_data)
  end

  describe 'instantiation' do
    it 'exists' do
      expect(@transaction).to be_a(Transaction)
    end

    it 'has attributes' do
      expect(@t_data).to be_a(Hash)
      expect(@transaction.id).to eq(6)
      expect(@transaction.invoice_id).to eq(8)
      expect(@transaction.credit_card_number).to eq("4242424242424242")
      expect(@transaction.credit_card_expiration_date).to eq("0220")
      expect(@transaction.result).to eq("success")
      expect(@transaction.created_at).to eq(Time)
      expect(@transaction.updated_at).to eq(Time)
    end
  end
end
