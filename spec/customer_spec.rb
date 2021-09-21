require './lib/customer'

RSpec.describe Customer do
  it 'exists' do
    c = Customer.new({
                      :id => 6,
                      :first_name => "Joan",
                      :last_name => "Clarke",
                      :created_at => Time.now,
                      :updated_at => Time.now
                      })
  expect(c).to be_an_instance_of(Customer)
end

  it 'has attributes' do
    c = Customer.new({
                      :id => 6,
                      :first_name => "Joan",
                      :last_name => "Clarke",
                      :created_at => Time.now,
                      :updated_at => Time.now
                      })
  expect(c.id).to be_an_instance_of(6)
  end
end
