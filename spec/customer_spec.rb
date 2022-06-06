require './lib/customer'

RSpec.describe Customer do
  before :each do
    @customer = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at  => '1994-05-07 23:38:43 UTC',
      :updated_at  => '2016-01-11 11:30:35 UTC',
      })
  end

  describe '#initialize' do
    it 'is an customer' do
      expect(@customer).to be_a Customer
    end

    it 'has a first name' do
      expect(@customer.first_name).to eq "Joan"
    end

    it 'has a last name' do
      expect(@customer.last_name).to eq "Clarke"
    end

    it 'has a created_at time' do
      expect(@customer.created_at).to eq '1994-05-07 23:38:43 UTC'
    end

    it 'has an update_at time' do
      expect(@customer.updated_at).to eq '2016-01-11 11:30:35 UTC'
    end
  end
end
