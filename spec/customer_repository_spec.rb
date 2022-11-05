require './spec_helper'

RSpec.describe CustomerRepository do 
  let (:customer_1) {Customer.new({:id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
})}
let (:customer_2) {Customer.new({:id => 7,
  :first_name => "Richard",
  :last_name => "Hammilton",
  :created_at => Time.now,
  :updated_at => Time.now
})}
let (:customer_3) {Customer.new({:id => 8,
  :first_name => "Mike",
  :last_name => "Lowry",
  :created_at => Time.now,
  :updated_at => Time.now
})}

  describe '#initialize' do 
    it 'will exist' do 
      customers = [customer_1, customer_2, customer_3]
      customer_repo = CustomerRepository.new(customers)

      expect(customer_repo).to be_a(CustomerRepository)
    end 
  end 

  describe '#all' do 
    it 'will return all of the customers' do 
      customers = [customer_1, customer_2, customer_3]
      customer_repo = CustomerRepository.new(customers)

      expect(customer_repo.all).to eq([customer_1, customer_2, customer_3])
    end 
  end 

  describe "#find_by_id" do 
    it 'will return the customer whos id matches id arguement' do 
      customers = [customer_1, customer_2, customer_3]
      customer_repo = CustomerRepository.new(customers)

      expect(customer_repo.find_by_id(6)).to eq(customer_1)
    end 
  end 

  describe "#find_all_by_first_name" do 
    it 'will return all customers with the first name' do 
      customers = [customer_1, customer_2, customer_3]
      customer_repo = CustomerRepository.new(customers)

      expect(customer_repo.find_all_by_first_name("Joan")).to eq([customer_1])
      expect(customer_repo.find_all_by_first_name("Larry")).to eq([])
    end 
  end 
end 

     