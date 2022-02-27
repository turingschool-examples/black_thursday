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
      last_name: 'Jenkins',
      created_at: Time.now,
      updated_at: Time.now
    )
  end

  it 'exists' do
    expect(@c).to be_a(Customer)
  end

  it 'has attributes' do
    expect(@c.id).to eq(24)
    expect(@c.first_name).to eq('Esteban')
    expect(@c.last_name).to eq('Jenkins')
    expect(@c.created_at).to eq(Time)
    expect(@c.updated_at).to eq(Time)
  end
end
