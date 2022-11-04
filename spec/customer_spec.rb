require './lib/customer'
require 'time'

RSpec.describe Customer do

  it 'exists and has attributes' do
    @time_now = Time.parse("2022-11-03 18:56:21.000000000 -0700")
    allow(Time).to receive(:now).and_return(@time_now)

    customer = Customer.new({ :id           => 6,
                              :first_name   => "Joan",
                              :last_name    => "Clarke",
                              :created_at   => Time.now,
                              :updated_at   => Time.now
                          })
    
    expect(customer).to be_a Customer
    expect(customer.id).to eq 6
    expect(customer.first_name).to eq "Joan"
    expect(customer.last_name).to eq "Clarke"
    expect(customer.created_at).to eq(@time_now)
    expect(customer.updated_at).to eq(@time_now)
  end
end