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

    it 'has an array of all transaction instances' do
      expect(@transaction_repo.all.length).to eq(10)

    end
  end

  describe 'methods' do
    it 'can find transactions given a unique id' do

      id = 8
      expected = @transaction_repo.find_by_id(id)
      expect(expected.id).to eq(id)
    end

    it 'can find transactions given a unique invoice id' do

      id = 290
      expected = @transaction_repo.find_all_by_invoice_id(id)
      expect(expected.invoice_id).to eq(id)
    end
  end
end
