require 'csv'
require 'pry'
require 'rspec'
require_relative 'spec_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/customer'

RSpec.describe Customer do
  before (:each) do
    @customer = Customer.new({ id: 1,
                first_name: "Joey",
                last_name: "Ondricka",
                created_at: "2012-03-27 14:54:09 UTC",
                updated_at: "2012-03-27 14:54:09 UTC" })
  end

  context 'Customer' do
# headers
#id,first_name,last_name,created_at,updated_at
    it 'can read Cusomer attributes' do
      expect(@customer.id).to eq(1)
      expect(@customer.first_name).to eq("Joey")
      expect(@customer.last_name).to eq("Ondricka")
#binding.pry

    end
  end
end
