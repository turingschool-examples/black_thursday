require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice'
require 'CSV'
require 'simplecov'
require 'bigdecimal'
SimpleCov.start

RSpec.describe Invoice do

  before(:each) do @i = Invoice.new({
                                    :id          => 6,
                                    :customer_id => 7,
                                    :merchant_id => 8,
                                    :status      => "pending",
                                    :created_at  => Time.now,
                                    :updated_at  => Time.now,
                                  })
  end

  it 'exists' do
    expect(@i).to be_a(Invoice)
  end

  it 'can read #customer_id' do
    expect(@i.customer_id).to eq(7)
  end

  it 'can read #customer_id' do
    expect(@i.merchant_id).to eq(8)
  end

  it 'can read #customer_id' do
    expect(@i.status).to eq(:pending)
  end

  it 'can read #customer_id' do
    expect(@i.created_at).to be_a(Time)
  end

  it 'can read #customer_id' do
    expect(@i.updated_at).to be_a(Time)
  end




end
