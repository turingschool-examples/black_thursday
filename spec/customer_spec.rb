require 'rspec'
require './lib/customer'

RSpec.describe Customer do
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
      expect(@customer).to be_a(Customer)
    end

    xit 'can return integer id' do
      expect(@customer.id).to eq(6)
    end

    xit "can return the first name" do
      expect(@customer.first_name).to eq("Joan")
    end

    xit "can return the last name" do
      expect(@customer.last_name).to eq("Clarke")
    end

    xit "can return a Time instance for the date the customer was first created" do
      expect(@customer.created_at).to be_a(Time)
    end

    it "can return a Time instance for the date the customer was last modified" do
      expect(@customer.updated_at).to be_a(Time)
    end

  end

end
