require './lib/customer_repository'
require './lib/customer'

RSpec.describe CustomerRepository do
  let(:cust_repo) {CustomerRepository.new}
  let(:cust1) {Customer.new({
                              :id         => 3,
                              :first_name => "Jimmy",
                              :last_name  => "John",
                              :created_at => Time.now,
                              :updated_at => Time.now
                            })}
  let(:cust2) {Customer.new({
                              :id         => 45,
                              :first_name => "Jane",
                              :last_name  => "Eileen",
                              :created_at => Time.now,
                              :updated_at => Time.now
                            })}

  it 'is a customer repository and stores an array of customers' do
    expect(cust_repo).to be_a(CustomerRepository)
  end

end