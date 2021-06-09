require_relative 'spec_helper'

RSpec.describe CustomerRepository do
  before :each do
    @mock_engine = double('CustomerRepository')
    @path = "fixture/customer_fixture.csv"
    @customer_repo = CustomerRepository.new(@path, @mock_engine)
  end

  describe 'instantiation' do
    it 'exists' do
      expect(@customer_repo).to be_a(CustomerRepository)
    end
  end
end
