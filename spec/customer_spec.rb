# 24,Esteban,Jenkins,2012-03-27 14:54:16 UTC,2012-03-27 14:54:16 UTC
require 'simplecov'
require 'time'
require_relative '../lib/customer'

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

  it 'can update customer with attributes' do
    attributes = {first_name: "Burt", last_name: "Reynolds"}

    intial_update_time = @c.updated_at
    @c.update(attributes)

    expect(@c.id).to eq(24)
    expect(@c.first_name).to eq('Burt')
    expect(@c.last_name).to eq('Reynolds')
    expect(@c.created_at).to eq(Time)
    expect(@c.updated_at).to eq(intial_update_time)
  end
end
