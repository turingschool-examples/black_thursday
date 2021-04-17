require_relative '../lib/sales_engine'
require_relative '../lib/customer'

RSpec.describe Customer do

  describe '#initialize' do

    customer = Customer.new({
                              :id => 6,
                              :first_name => "Joan",
                              :last_name => "Clarke",
                              :created_at => Time.now,
                              :updated_at => Time.now
                            })
    it 'exists' do
      expect(customer).to be_instance_of(Customer)
    end

    it 'has attributes accessible' do

      expect(customer.id).to eq(6)
      expect(customer.first_name).to eq("Joan")
      expect(customer.last_name).to eq("Clarke")
      expect(customer.created_at.class).to eq(Time)
      expect(customer.updated_at.class).to eq(Time)
    end
  end


end
