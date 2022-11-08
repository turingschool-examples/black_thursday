require './lib/requirements'

RSpec.describe Customer do

  let!(:customer) {Customer.new( {
                  :id => 1,
                  :first_name => 'bob',
                  :last_name => 'burger',
                  :created_at => Time.now.to_s,
                  :updated_at => Time.now.to_s
                  }, nil)}
  
  it 'is a customer class' do
    expect(customer).to be_a(Customer)
    
  end
  
  
  
end