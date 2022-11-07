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
    expect(customer1.id).to eq(6)
    expect(customer1.first_name).to eq("Joan")
    expect(customer1.last_name).to eq("Clarke")
    expect(customer1.created_at).to be_a(Time)
    expect(customer1.updated_at).to be_a(Time)
  end
end