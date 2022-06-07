require 'csv'
require './lib/customer'
require_relative '../lib/customer'

RSpec.describe Customer do
  before :each do
        @c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    })
  end

    it 'exists & has attributes' do
      expect(@c).to be_a Customer
      expect(@c.id).to eq(6)
      expect(@c.first_name).to eq("Joan")
      expect(@c.last_name).to eq("Clarke")
      expect(@c.created_at).to be_a Time
      expect(@c.updated_at).to be_a Time
    end
end
