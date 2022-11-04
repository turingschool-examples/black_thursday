require_relative '../lib/customer'
require 'time'

RSpec.describe Customer do
  it 'exists and has attributes' do
    time = Time.now.to_s
    c = Customer.new({
      :id         => 6,
      :first_name => 'Joan',
      :last_name  => 'Clarke',
      :created_at => time,
      :updated_at => time
    })
    expect(c).to be_a(Customer)
    expect(c.id).to eq 6
    expect(c.first_name).to eq ('Joan')
    expect(c.last_name).to eq ('Clarke')
    expect(c.created_at).to eq Time.parse(time)
    expect(c.updated_at).to eq Time.parse(time)
  end
end
