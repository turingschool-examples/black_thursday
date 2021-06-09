require_relative 'spec_helper'

RSpec.describe TransactionRepository do
  before :each do
    @mock_engine = double('TransactionRepository')
    @path = "fixture/transaction_fixture.csv"
    @transaction_repo = TransactionRepository.new(@path, @mock_engine)
  end

  describe 'instantiation' do
    it 'exists' do
      expect(@transaction_repo).to be_a(TransactionRepository)
    end

    it 'returns an array of all known transactions with readable attributes' do
      expect(@transaction_repo.all).to be_an(Array)
      expect(@transaction_repo.all.length).to eq(10)
      expect(@transaction_repo.all.first.id).to eq(1)
      expect(@transaction_repo.all.first.invoice_id).to eq(2179)
      expect(@transaction_repo.all.first.credit_card_number).to eq(4068631943231473)
      expect(@transaction_repo.all.first.credit_card_expiration_date).to be_a(String)
      expect(@transaction_repo.all.first.result).to eq('success')
      expect(@transaction_repo.all.first.created_at).to be_a(Time)
      expect(@transaction_repo.all.first.updated_at).to be_a(Time)
    end
  end

  describe 'methods' do
    it 'can find transactions given a unique id' do

      expect(@transaction_repo.find_by_id(9)).to eq(@transaction_repo.all[8])
    end

    it 'can find transactions given a unique invoice id' do

      id = 290
      expect(@transaction_repo.find_all_by_invoice_id(id)).to be_an(Array)
      expect(@transaction_repo.find_all_by_invoice_id(id).length).to eq(1)
      id = 8448
      expect(@transaction_repo.find_all_by_invoice_id(id)).to eq([])
    end
  end
end
