require 'pry'
require_relative 'spec_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'

RSpec.describe CustomerRepository do
  before(:each) do
    se = SalesEngine.from_csv({ :customers => "./data/customers.csv"})
    @customers = se.customers
  end

  it "exists" do
    expect(@customers).to be_a(CustomerRepository)
  end

  it "#all returns array of all know InvoiceItem instances" do
    expect(@customers.all.count).to eq(1000)
  end

  it "#find_all_by_first_name" do
    fragment = "oe"
    expected = @customers.find_all_by_first_name(fragment)
    
    expect(expected.length).to eq 8
    expect(expected.first.class).to eq Customer
  end
end
