require_relative '../lib/customer_repository'

RSpec.describe CustomerRepository do
  it "all returns all customers" do
    expected = engine.customers.all
    expect(expected.length).to eq 1000
    expect(expected.first.class).to eq Customer
  end
end
