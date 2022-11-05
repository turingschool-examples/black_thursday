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
    
    it 'will have a first_name' do 

      expect(customer.first_name).to eq("Joan")
    end 

    it 'will have a last name' do 
      
      expect(customer.last_name).to eq("Clarke")
    end 

    it 'will have a value for updated_at' do 
      
      expect(customer.updated_at).to be < (Time.now)
    end 

    it 'will have a value for created_at' do 

      expect(customer.created_at).to be < (Time.now)
    end 
  end 

  describe '#update first name' do 
    it 'will update the first name' do 
      customer.update_first_name("Joanne")

      expect(customer.first_name).to eq("Joanne")
    end 
  end 

  describe '#update last name' do 
    it 'will update the last name' do
      customer.update_last_name("Clark")

      expect(customer.last_name).to eq("Clark")
    end 
  end 
  
  describe "update time" do 
    it 'will update the time' do 
      original_update = customer.updated_at
      
      expect(customer.update_time).to be > (original_update)
    end 
  end 
end 
    