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
      expect(@c.find_by_id(334_456)).to be nil
    end
  end

  describe '#find_all_by_first_name' do
    it 'can return all customers with given first name' do
      expect(@c.find_all_by_first_name('Joey')).to include(@c.all[0])
      expect(@c.find_all_by_first_name('Joey')).to be_a Array
      expect(@c.find_all_by_first_name('Gwenifer')).to be_a Array
    end
  end

  describe '#find_all_by_last_name' do
    it 'can return all customers with given last name' do
      expect(@c.find_all_by_first_name('Kris')).to include(@c.all[11])
      expect(@c.find_all_by_first_name('Kris')).to be_a Array
      expect(@c.find_all_by_first_name('Maaaaaaar')).to be_a Array
    end
  end

  describe '#create' do
    it 'creates a customer with given attributes' do
      first_name = "Georgamin-Keanu"
      last_name = "McSabertoothson III"
      @c.create(first_name, last_name)

      expect(@c.all.last).to be_a Customer
      expect(@c.all.last.first_name).to eq("Georgamin-Keanu")
      expect(@c.all.last.last_name).to eq("McSabertoothson III")
      expect(@c.all.customer_id.last).to eq(1001)
    end
  end
end
