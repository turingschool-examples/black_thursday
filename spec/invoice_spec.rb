require 'SimpleCov'
SimpleCov.start

require_relative '../lib/invoice'
require 'bigdecimal'

RSpec.describe Invoice do
  before :each do
    @data = {
              :id          => 6,
              :customer_id => 7,
              :merchant_id => 8,
              :status      => 'pending',
              :created_at  => Time.now.to_s,
              :updated_at  => Time.now.to_s,
            }

    @i = Invoice.new(@data)
  end

  it 'exists' do
    expect(@i).to be_an_instance_of(Invoice)
  end

  it 'status returns the invoice status as symbol' do
    expect( @i.status).to eq :pending
    expect( @i.status.class).to eq Symbol
  end

  it 'initializes with attributes' do
    expect(@i.id).to eq(@data[:id])
    expect(@i.customer_id).to eq(@data[:customer_id])
    expect(@i.merchant_id).to eq(@data[:merchant_id])
    expect(@i.status).to eq(@data[:status].to_sym)
    expect(@i.created_at).to eq(Time.parse(@data[:created_at]))
    expect(@i.updated_at).to eq(Time.parse(@data[:updated_at]))
  end

  it 'can create time' do
    allow(@i).to receive(:created_at).and_return(Time.parse('2021-06-11 02:34:56 UTC'))
    expect(@i.created_at).to eq(Time.parse('2021-06-11 02:34:56 UTC'))
  end
end
