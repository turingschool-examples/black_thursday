require 'rspec'
require './lib/customer'

RSpec.describe Customer do

  let!(:customer) {Customer.new( {
                  :id => 1,
                  :first_name => 'bob',
                  :last_name => 'burger',
                  :created_at => Time.now,
                  :updated_at => Time.now
                  }, nil)}
  
  it 'is a customer class' do
    require 'pry'; binding.pry
    expect(customer).to be_a(Customer)
    
  end
  
  
  
end