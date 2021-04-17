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

  describe '#time_check' do
    customer = Customer.new({
                              :id => 6,
                              :first_name => "Joan",
                              :last_name => "Clarke",
                              :created_at => Time.now,
                              :updated_at => Time.now
                            })
    it 'returns input as originally passed in if input is class Time' do
      time_object = Time.parse("2007-06-04 21:35:10 UTC")
      expect(customer.time_check(time_object)).to eq(time_object)
    end

    it 'returns input converted to Time object if input is not class Time' do
      expect(customer.time_check("2007-06-04 21:35:10 UTC")).to eq(Time.parse("2007-06-04 21:35:10 UTC"))
    end
  end

end
