require 'csv'
require './lib/customer'
require './lib/customerrepository'
require './lib/sales_engine'
require 'rspec'
require 'bigdecimal'
require 'bigdecimal/util'
require 'objspace'

describe Customer do
  it 'exists' do
    c = Customer.new({
                      :id => 6,
                      :first_name => "Joan",
                      :last_name => "Clarke",
                      :created_at => Time.now,
                      :updated_at => Time.now
                    })
    expect(c).to be_a(Customer)
  end
end
