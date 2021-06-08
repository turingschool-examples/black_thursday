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
  end
end
