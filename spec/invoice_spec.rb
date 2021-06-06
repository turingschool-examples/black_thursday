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

  it 'initializes with attributes' do
    expect(@i.id).to eq(@data[:id])
    expect(@i.customer_id).to eq(@data[:customer_id])
    expect(@i.merchant_id).to eq(@data[:merchant_id])
    expect(@i.status).to eq(@data[:status])
    expect(@i.created_at).to eq(Time.parse(@data[:created_at]))
    expect(@i.updated_at).to eq(Time.parse(@data[:updated_at]))
  end
end
