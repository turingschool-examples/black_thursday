require_relative 'spec_helper'
require_relative '../lib/customer'
require 'csv'


RSpec.describe Customer do
  before :each do
    @time = Time.now.utc.strftime("%m-%d-%Y %H:%M:%S %Z")
    @repo = double('repo')
    @data = {
      :id => 6,
      :first_name => "Persephone",
      :last_name => "Rose",
      :created_at => @time,
      :updated_at => @time
    }
    @c = Customer.new(@data, @repo)
  end

  it 'exists' do
    expect(@c).to be_a(Customer)
  end

  it 'has attributes' do
    expect(@c.id).to eq(6)
    expect(@c.first_name).to eq("Persephone")
    expect(@c.last_name).to eq("Rose")
    expect(@c.created_at).to eq(Time.parse(@time))
    expect(@c.updated_at).to eq(Time.parse(@time))
  end

  it 'can create a customer' do
    attributes = {
      :first_name => "Tomas",
      :last_name => "Smith",
    }

    allow(@repo).to receive(:new_customer_id_number).and_return(4)
    expect(Customer.create(attributes, @repo)).to be_a(Customer)
  end

  it 'can update a customer' do
    attributes = {
      :first_name => "Tomas",
      :last_name => "Smith",
    }

    @c.update(attributes)
    expect(@c.first_name).to eq("Tomas")
  end
end
