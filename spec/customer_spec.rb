require 'rspec'
require './lib/customer'
require 'time'


RSpec.describe Customer do
  before(:each) do
    @customer = Customer.new({id: "1",
                          first_name: "Joey",
                          last_name: "Ondricka",
                          created_at: 2012-03-27,
                          updated_at: 2012-03-27},
                          self)
  end
  describe 'instantiation' do
    it 'exists' do

      expect(@customer).to be_a(Customer)
    end

    it 'has readable attributes' do

      expect(@customer.id).to eq(1)
      expect(@customer.first_name).to eq("Joey")
      expect(@customer.last_name).to eq("Ondricka")
      expect(@customer.created_at).to eq("2012-03-27")
      expect(@customer.updated_at).to eq("2012-03-27")
      expect(@customer.repo).to eq(self)
    end
  end

  describe 'has a method that' do
    it 'can update the updated_at time' do
      expect(@customer.updated_at).to eq("2012-03-27")

      @customer.update_time

      expect(@customer.updated_at.to_i).to eq(Time.now.to_i)
    end

    it 'can change the existing status' do
      expect(@customer.status).to eq("pending")

      @customer.change_status("LOST AT SEA")

      expect(@customer.status).to eq("LOST AT SEA")
    end
  end
end
