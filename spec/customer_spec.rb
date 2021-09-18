require "Rspec"
require_relative "../lib/customer"

describe Customer do
  before :each do
    @c = Customer.new({
      :id          => '1',
      :first_name  => 'Joan',
      :last_name   => 'Clarke',
      :created_at  => '2016-01-11 09:34:06 UTC',
      :updated_at  => '2007-06-04 21:35:10 UTC',
    })
  end

  it '#customer' do
    expect(@c).to be_a Customer
  end

  it '#id' do
    expect(@c.id).to eq 1
  end

  it '#first_name' do
    expect(@c.first_name).to eq 'Joan'
  end

  it '#last_name' do
    expect(@c.last_name).to eq 'Clarke'
  end

  it '#created_at' do
    expect(@c.created_at).to be_a Time
  end

  it '#updated_at' do
    expect(@c.updated_at).to be_a Time
  end
end
