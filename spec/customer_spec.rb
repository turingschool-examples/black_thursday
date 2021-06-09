require_relative 'spec_helper'

RSpec.describe Customer do
  before :each do
    @customer_data = {
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @customer = Customer.new(@customer_data)
  end
  describe 'instantiation' do
    it 'exists' do
      expect(@customer).to be_a(Customer)
    end
  end
end
