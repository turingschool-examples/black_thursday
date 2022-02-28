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
      created_at: "2022-02-26 03:17:26 UTC",
      updated_at: "2022-02-26 03:17:26 UTC"
    )
  end

  it 'exists' do
    expect(@c).to be_a(Customer)
  end

  it 'has attributes' do
    expect(@c.id).to eq(24)
    expect(@c.first_name).to eq('Esteban')
    expect(@c.last_name).to eq('Jenkins')
    expect(@c.created_at).to eq("2022-02-26 03:17:26 UTC")
    expect(@c.updated_at).to eq("2022-02-26 03:17:26 UTC")
  end

  it 'can update customer with attributes' do
    attributes = { first_name: "Burt", last_name: "Reynolds" }

    @c.updated_at = "2022-02-26 03:17:26 UTC"
    @c.update(attributes)

    expect(@c.id).to eq(24)
    expect(@c.first_name).to eq('Burt')
    expect(@c.last_name).to eq('Reynolds')
    expect(@c.created_at).to eq("2022-02-26 03:17:26 UTC")
    expect(@c.updated_at).to eq("2022-02-26 03:17:26 UTC")
  end
end
