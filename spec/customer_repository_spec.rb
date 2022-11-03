require_relative '../lib/customer_repository'

RSpec.describe CustomerRepository do
  it 'exists' do
    cust = CustomerRepository.new
    expect(cust).to be_a(CustomerRepository)
  end
end