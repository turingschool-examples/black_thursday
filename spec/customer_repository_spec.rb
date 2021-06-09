require 'rspec'
require_relative './spec_helper'

RSpec.describe CustomerRepository do
  describe 'instantiation' do
    it 'exists' do
      se = SalesEngine.new({
         :customers => 'spec/fixtures/customers.csv'
       })
      cr = CustomerRepository.new('spec/fixtures/customers.csv', se)

      expect(cr).to be_a(CustomerRepository)
    end
  end
end