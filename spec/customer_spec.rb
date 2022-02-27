require 'csv'
require './lib/customer'

RSpec.describe Customer do

  before(:each) do
    @c = Customer.new({
  :id => 6,
  :first_name => "Joan",
  :last_name => "Clarke",
  :created_at => Time.now,
  :updated_at => Time.now
  })
  end

  it 'exists' do
    expect(@c).to be_an_instance_of(Customer)
  end

end
