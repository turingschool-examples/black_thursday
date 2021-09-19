# frozen_string_literal: true

require 'SimpleCov'
SimpleCov.start

require 'rspec'
require 'csv'
require './lib/customer_repository'
require './lib/customer'

describe CustomerRepository do
  before(:each) do
    @cr = CustomerRepository.new('./data/customers.csv')
  end

  it 'exists' do
    expect(@cr).to be_a CustomerRepository
  end

  describe '#all' do
    it 'returns all customers' do
      expect(@cr.all).to be_a Array

      @cr.all.each do |customer|
        expect(customer).to be_a Customer
      end
    end
  end

  describe '#find_by_id' do
    it 'can find customer by given id' do
      expect(@cr.find_by_id(3)).to eq(@cr.all[2])
      expect(@cr.find_by_id(334_456)).to be nil
    end
  end

  describe '#find_all_by_first_name' do
    it 'can return all customers with given first name' do
      expect(@cr.find_all_by_first_name('Joey')).to include(@cr.all[0])
      expect(@cr.find_all_by_first_name('Joey')).to be_a Array
      expect(@cr.find_all_by_first_name('Gwenifer')).to be_a Array
    end
  end

  describe '#find_all_by_last_name' do
    it 'can return all customers with given last name' do
      expect(@cr.find_all_by_last_name('Kris')).to include(@cr.all[10])
      expect(@cr.find_all_by_last_name('Kris')).to be_a Array
      expect(@cr.find_all_by_last_name('Maaaaaaar')).to be_a Array
    end
  end

  describe '#create' do
    it 'creates a customer with given attributes' do
      first_name = "Georgamin-Keanu"
      last_name = "McSabertoothson III"
      @cr.create(first_name, last_name)

      expect(@cr.all.last).to be_a Customer
      expect(@cr.all.last.first_name).to eq("Georgamin-Keanu")
      expect(@cr.all.last.last_name).to eq("McSabertoothson III")
      expect(@cr.all.last.id).to eq(1001)
    end
  end

  describe '#update' do
    it 'updates a specific customer with the provided attributes' do
      expect(@cr.update(5, "Joe Bob")).to eq(@cr.all[4])
      expect(@cr.all[4].first_name).to eq('Joe')
      expect(@cr.all[4].last_name).to eq('Bob')
    end
  end
end
