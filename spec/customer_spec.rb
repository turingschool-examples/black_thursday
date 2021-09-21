require './lib/customer'

RSpec.describe Customer do
  it 'exists' do
    c = Customer.new({
                      :id => 1,
                      :first_name => "Joey",
                      :last_name => "Ondricka",
                      :created_at => "2012-03-27 14:54:09 UTC",
                      :updated_at => "2012-03-27 14:54:09 UTC"
                      })
  expect(c).to be_an_instance_of(Customer)
end

  it 'has attributes' do
    c = Customer.new({
                      :id => 1,
                      :first_name => "Joey",
                      :last_name => "Ondricka",
                      :created_at => "2012-03-27 14:54:09 UTC",
                      :updated_at => "2012-03-27 14:54:09 UTC"
                      })

  expect(c.id).to eq(1)
  expect(c.first_name).to eq("Joey")
  expect(c.last_name).to eq("Ondricka")
  expect(c.created_at).to eq("2012-03-27 14:54:09 UTC")
  expect(c.updated_at).to eq("2012-03-27 14:54:09 UTC")
  end
end
