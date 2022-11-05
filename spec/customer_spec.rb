require './spec_helper'

RSpec.describe Customer do 
  let (:customer) {Customer.new({:id => 6,
                                  :first_name => "Joan",
                                  :last_name => "Clarke",
                                  :created_at => Time.now,
                                  :updated_at => Time.now
  })}
  describe "#initialize" do 
    it 'will exist' do 

      expect(customer).to be_a(Customer)
    end 

    it 'will have an id' do 

      expect(customer.id).to eq(6)
    end 
  end 
end 
    