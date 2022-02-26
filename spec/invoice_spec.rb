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

  it 'can read #id' do
    expect(@i.id).to eq(6)
  end


end
