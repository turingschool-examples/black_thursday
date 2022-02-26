# 24,Esteban,Jenkins,2012-03-27 14:54:16 UTC,2012-03-27 14:54:16 UTC
require 'simplecov'
require 'time'
require './lib/customer'

SimpleCov.start

RSpec.describe Customer do
  before :each do
    @c = Customer.new(
      id: 24,
      first_name: 'Esteban',
      last_name:  'Jenkins',
      created_at:  Time.now,
      updated_at:  Time.now
    )
  end

  it 'exists' do
    expect(@c).to be_a(Customer)
  end 
end
