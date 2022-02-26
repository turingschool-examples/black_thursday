require 'CSV'
require './lib/customer_repository'
require './lib/customer'
require 'simplecov'
require 'bigdecimal'

SimpleCov.start

RSpec.describe CustomerRepository do
  before :each do
    @cr = CustomerRepository.new

    it 'exists' do
      expect(@cr).to be_a(CustomerRepository)
    end

    it 'has attributes' do
      expect(@cr.all).to be_a(Array)
    end
end
