require 'SimpleCov'
SimpleCov.start

require_relative '../lib/customer'
require 'bigdecimal'

RSpec.describe Customer do
  before(:each) do
    @c = Customer.new({
      :id          => 1,
      :first_name  => 'Jennifer',
      :last_name   => 'Flowers',
      :created_at  => '2021-06-11 09:34:06 UTC',
      :updated_at  => '2021-06-11 09:34:06 UTC',
    })
  end

  it 'exists' do
    expect(@c).to be_an_instance_of(Customer)
  end
  it 'has attributes' do
    expect(@c.id).to eq(1)
    expect(@c.first_name).to eq('Jennifer')
    expect(@c.last_name).to eq('Flowers')
    expect(@c.created_at).to eq(Time.parse('2021-06-11 09:34:06 UTC'))
    expect(@c.updated_at).to eq(Time.parse('2021-06-11 09:34:06 UTC'))
  end

  it 'can parse time or create time' do
    expect(@c.created_at).to be_a(Time)
    expect(@c.updated_at).to be_a(Time)
  end

  it 'can update attributes' do
    @c.update({
      :first_name => 'Dan',
      :last_name  => 'Spring'
      })

    expect(@c.first_name).to eq('Dan')
    expect(@c.last_name).to eq('Spring')
    expect(@c.updated_at).to be_a(Time)

    @c.update({
      :first_name => 'Sam',
      })

    expect(@c.first_name).to eq('Sam')
    expect(@c.last_name).to eq('Spring')
    expect(@c.updated_at).to be_a(Time)
  end
end
