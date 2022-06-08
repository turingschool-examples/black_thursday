require './lib/transaction'

RSpec.describe Transaction do
  before :each do
    @transaction = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at  => Time.parse('1994-05-07 23:38:43 UTC'),
      :updated_at  => Time.parse('2016-01-11 11:30:35 UTC'),
      })
  end

  describe '#initialize' do
    it 'is an transaction' do
      expect(@transaction).to be_a Transaction
    end

    it 'has an id' do
      expect(@transaction.id).to eq 6
    end

    it 'has a invoice_id' do
      expect(@transaction.invoice_id).to eq 8
    end

    it 'has a credit_card_number' do
      expect(@transaction.credit_card_number).to eq "4242424242424242"
    end

    it 'has a credit_card_expiration_date' do
      expect(@transaction.credit_card_expiration_date).to eq "0220"
    end

    it 'has a result' do
      expect(@transaction.result).to eq :success
    end

    it 'has a created_at time' do
      expect(@transaction.created_at).to eq Time.parse('1994-05-07 23:38:43 UTC')
    end

    it 'has an update_at time' do
      expect(@transaction.updated_at).to eq Time.parse('2016-01-11 11:30:35 UTC')
    end
  end
end
