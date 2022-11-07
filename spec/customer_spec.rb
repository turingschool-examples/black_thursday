require './lib/customer'

RSpec.describe Customer do
  it 'exists and has attributes' do
    customer1 = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    })

    expect(customer1).to be_a(Customer)
  end
end