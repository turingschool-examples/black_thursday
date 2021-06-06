require 'bigdecimal'
require_relative 'spec_helper'

RSpec.describe Customer do

  before(:each) do
    @paths = {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :customers => "./data/customers.csv"

    }
    @se = SalesEngine.from_csv(@paths)
    @cr = @se.items
  end

  it 'exists' do
    c = Customer.new({
    :id          => 500,
    :first_name        => 'Hailey',
    :last_name => 'Veum',
    :created_at  => Time.now,
    :updated_at  => Time.now

    }, @cr)

    expect(i).to be_a(Customer)
  end

  it 'has attributes' do
    time_stub = '2021-05-30 11:30:51 -0500'
    allow(Time).to receive(:now).and_return(time_stub)

    c = Customer.new({
    :id          => 500,
    :first_name        => 'Hailey',
    :last_name => 'Veum',
    :created_at  => Time.now,
    :updated_at  => Time.now
    }, @cr)

    expect(c.id).to eq(500)
    expect(c.first_name).to eq('Haile')
    expect(c.last_name).to eq('Veum')
    expect(c.created_at.to_s).to eq(Time.now)
    expect(c.updated_at.to_s).to eq(Time.now)
  end

  it 'stores its states in a hash' do
    time_stub = '2021-05-30 11:30:51.343158 -050'
    allow(Time).to receive(:now).and_return(time_stub)

    c  c = Customer.new({
      :id          => 500,
      :first_name        => 'Hailey',
      :last_name => 'Veum',
      :created_at  => Time.now,
      :updated_at  => Time.now
      }, @cr)
    c_hash = c.to_hash

    expect(c_hash).to be_a(Hash)
    expect(c_hash.keys.length).to eq(5)
    expect(c_hash.values.length).to eq(5)
    expect(c_hash[:id]).to eq(i.id)
    expect(c_hash[:first_name]).to eq(i.first_name)
    expect(c_hash[:last_name]).to eq(c.last_name)
    expect(c_hash[:created_at]).to eq(c.created_at)
    expect(c_hash[:updated_at]).to eq(c.updated_at)
  end

end
