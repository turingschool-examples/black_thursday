require 'rspec'
require './lib/customer'
require './lib/customer_repository'

RSpec.describe CustomerRepository do
  describe 'Iteration 3' do
    before :each do
      @c = Customer.new({
          :id => 6,
          :first_name => "Joan",
          :last_name => "Clarke",
          :created_at => Time.now,
          :updated_at => Time.now
        })
      @
    end

    it 'exists' do
      expect(@customer_repository).to be_a(CustomerRepository)
    end

    it 'has attributes' do
      expect(@customer_repository.attribute).to eq()
    end

    it "can return an array of all customer instances" do

    end

    it "can find by id" do

    end

    it "can find all by first name" do

    end

    it "can find all by last name" do

    end

    it "can create a new customer" do

    end

    it "can update customer attributes" do

    end

    it "can delete customer instance (by id)" do

    end

  end

end
