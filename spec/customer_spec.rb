require_relative 'spec_helper'

RSpec.describe Customer do
  before :each do
    @mock_repo = double("CustomerRepository")
    @customer_data = {
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @customer = Customer.new(@customer_data, @mock_repo)
  end
  describe 'instantiation' do
    it 'exists' do
      expect(@customer).to be_a(Customer)
    end

    it 'has attributes' do
      expect(@customer_data).to be_a(Hash)
      expect(@customer.id).to eq(6)
      expect(@customer.first_name).to eq("Joan")
      expect(@customer.last_name).to eq("Clarke")
      expect(@customer.created_at).to be_a(Time)
      expect(@customer.updated_at).to be_a(Time)
    end
  end
end
