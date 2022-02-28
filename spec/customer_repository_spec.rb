require 'pry'
require 'time'
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

  it "#find_all_by_last_name returns all customers with matching last name" do
      fragment = "On"
      expected = @customers.find_all_by_last_name(fragment)

      expect(expected.length).to eq 85
      expect(expected.first.class).to eq Customer
    end

  it "#create a customer" do
    attributes = {
       :first_name => "John",
       :last_name => "Doe",
       :created_at => Time.now,
       :updated_at => Time.now
     }
     @customers.create(attributes)
     expected = @customers.find_by_id(1001)
     expect(expected.first_name).to eq "John"
  end

  it "#update updates a customer" do
    attributes = {
       :first_name => "John",
       :last_name => "Doe",
       :created_at => Time.now,
       :updated_at => Time.now
    }
    @customers.create(attributes)

    original_time = @customers.find_by_id(1001).updated_at
    attributes = { last_name: "Smith" }
    @customers.update(1001, attributes)

    expected = @customers.find_by_id(1001)
    expect(expected.last_name).to eq "Smith"
    expect(expected.first_name).to eq "John"
    expect(expected.updated_at).to be > original_time
  end
  it "#deletes by id" do
    @customers.delete(1)
    expected = @customers.find_by_id(1)
    expect(expected).to eq nil
  end
end
