require './lib/customer'
require 'time'

RSpec.describe Customer do
  let(:time) {Time.now}
  let(:c) {Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => time,
    :updated_at => time
  })}

  it 'exists and has attributes' do
    expect(c).to be_a Customer
    expect(c.id).to eq 6
    expect(c.first_name).to eq "Joan"
    expect(c.last_name).to eq "Clarke"
    expect(c.created_at).to eq time
    expect(c.updated_at).to eq time
  end
end