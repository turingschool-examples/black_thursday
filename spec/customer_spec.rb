# frozen_string_literal: true

require 'SimpleCov'
SimpleCov.start

require 'rspec'
require './lib/customer'

describe Customer do
  before(:each) do
    @customer = {
      id:          6,
      first_name:  'Joan',
      last_name:   'Clarke',
      created_at:  Time.now.to_s,
      updated_at:  Time.now.to_s
    }
    @c = Customer.new(@customer)
  end

  it 'creates an instance of customer' do
    expect(@c).to be_a Customer
  end

  describe '#id' do
    it 'returns a customer id' do
      expect(@c.id).to eq(6)
    end
  end

  describe '#first_name' do
    it 'returns a customer first name' do
      expect(@c.first_name).to eq('Joan')
    end
  end

  describe '#last name' do
    it 'returns a customer last name' do
      expect(@c.last_name).to eq('Clarke')
    end
  end

  describe '#created_at' do
    it 'returns a time customer was created' do
      expect(@c.created_at).to eq(Time.parse(@customer[:created_at]))
    end
  end

  describe '#updated_at' do
    it 'returns a time customer was updated' do
      expect(@c.updated_at).to eq(Time.parse(@customer[:updated_at]))
    end
  end
end
