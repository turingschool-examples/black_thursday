require 'customer'

RSpec.describe Customer do
  describe 'instantiation' do
    it '::new' do
      customer1 = Customer.new({:id => 6,
                                :first_name => "Joan",
                                :last_name => "Clarke",
                                :created_at => Time.now,
                                :updated_at => Time.now
                              })

      expect(customer1).to be_an_instance_of(Customer)
    end

    it 'has attributes' do
      customer1 = Customer.new({:id => 6,
                                :first_name => "Joan",
                                :last_name => "Clarke",
                                :created_at => Time.now,
                                :updated_at => Time.now
                              })

      expect(customer1.id).to eq(6)
      expect(customer1.first_name).to eq("Joan")
      expect(customer1.last_name).to eq("Clarke")
      expect(customer1.created_at).to be_an_instance_of(Time)
      expect(customer1.updated_at).to be_an_instance_of(Time)
    end
  end
end
