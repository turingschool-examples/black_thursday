require 'csv'
require 'time'
require './lib/customer'

RSpec.describe Customer do

  before(:each) do
    @c = Customer.new({
  :id => 1,
  :first_name => "Joey",
  :last_name => "Ondricka",
  :created_at => Time.parse("2012-03-27 14:54:09 UTC"),
  :updated_at => Time.parse("2012-03-27 14:54:09 UTC")
  })
  end

  it 'exists' do
    expect(@c).to be_an_instance_of(Customer)
  end

  it 'has retreivable attributes' do
    expect(@c.id).to eq(1)
    expect(@c.first_name).to eq("Joey")
    expect(@c.last_name).to eq("Ondricka")
  end

  it 'returns a time instance for the date the invoice item was created' do
    expect(@c.created_at).to eq Time.parse("2012-03-27 14:54:09 UTC")
  end

  it 'returns a time instance for the date the invoice item was last updated' do
    expect(@c.created_at).to eq Time.parse("2012-03-27 14:54:09 UTC")
  end


end
