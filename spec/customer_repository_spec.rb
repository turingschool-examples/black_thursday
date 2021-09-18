# frozen_string_literal: true

require 'SimpleCov'
SimpleCov.start

require 'rspec'
require 'csv'
require './lib/customer_repository'
require './lib/customer'

describe CustomerRepository do
  before(:each) do
    @c = CustomerRepository.new('./data/customers.csv')
  end

  it 'exists' do
    expect(@c).to be_a CustomerRepository
  end

  describe '#all' do
    it 'returns all customers' do
      expect(@c.all).to be_a Array

      @c.all.each do |customer|
        expect(customer).to be_a Customer
      end
    end
  end

  describe '#find_by_id' do
    it 'can find customer by given id' do
      expect(@c.find_by_id(3)).to eq(@c.all[2])
    end
  end
end
