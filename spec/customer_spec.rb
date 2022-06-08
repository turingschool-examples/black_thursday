require './lib/customer'

RSpec.describe Customer do
  before :each do
    @customer = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at  => Time.parse('1994-05-07 23:38:43 UTC'),
      :updated_at  => Time.parse('2016-01-11 11:30:35 UTC'),
      })
  end

  describe '#initialize' do
    it 'is an customer' do
      expect(@customer).to be_a Customer
    end

    it 'has an id' do
      expect(@customer.id).to eq 6
    end

    it 'has a first name' do
      expect(@customer.first_name).to eq "Joan"
    end

    it 'has a last name' do
      expect(@customer.last_name).to eq "Clarke"
    end

    it 'has a created_at time' do
      expect(@customer.created_at).to eq Time.parse('1994-05-07 23:38:43 UTC')
    end

    it 'has an update_at time' do
      expect(@customer.updated_at).to eq Time.parse('2016-01-11 11:30:35 UTC')
    end
  end
end
