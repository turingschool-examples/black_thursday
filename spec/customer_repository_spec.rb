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

  customers = [customer_1, customer_2, customer_3]
  customer_repo = CustomerRepository(customers)

  describe '#initialize' do 
    it 'will exist' do 

      expect(customer_repo).to be_a(CustomerRepository)
    end 
  end 
end 

     