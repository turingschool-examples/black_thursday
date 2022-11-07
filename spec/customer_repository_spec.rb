require_relative '../lib/customer_repository'
require './lib/sales_engine'
require "spec_helper_2"

RSpec.describe CustomerRepository do
  it 'exists and has no customers by default' do
    expect(engine.customers).to be_a(CustomerRepository)
  end

  # find_by_id - returns either nil or an instance of Customer with a matching ID
  it 'can find customers by id' do
    expect(engine.customers.find_by_id(0)).to eq (nil)
    expect(engine.customers.find_by_id(6)).to be_a (Customer)
    expect(engine.customers.find_by_id(6).first_name).to eq ("Heber")
  end

  # all - returns an array of all known Customer instances
  it 'returns an array of all known Customer instances' do
    expect(engine.customers.all).to be_a(Array)
    expect(engine.customers.all.first).to be_a(Customer)
  end
  # find_all_by_first_name - returns either [] or one or more matches which have a first name matching the substring fragment supplied
  it 'finds all by first name -if first name does not exist returns nil' do
    expect(engine.customers.find_all_by_first_name("Coopernicus")).to eq []
    expect(engine.customers.find_all_by_first_name("Lisa")).to eq ([engine.customers.all[60], engine.customers.all[66], engine.customers.all[599], engine.customers.all[646]])
    expect(engine.customers.find_all_by_first_name("oe")).to eq ([engine.customers.all[0], engine.customers.all[191], engine.customers.all[308], engine.customers.all[446], engine.customers.all[504], engine.customers.all[567], engine.customers.all[588], engine.customers.all[823]])
  end

  # find_all_by_last_name - returns either [] or one or more matches which have a last name matching the substring fragment supplied
  it 'finds all by last name -if last name does not exist returns nil' do
    expect(engine.customers.find_all_by_last_name("Schnickelfritz")).to eq []
    expect(engine.customers.find_all_by_last_name("Fadel")[0]).to eq (engine.customers.all[8])
    expect(engine.customers.find_all_by_last_name("On").length).to eq 85

  end

  # create(attributes) - create a new Customer instance with the provided attributes. The new Customer’s id should be the current highest Customer id plus 1.
  it 'creates a new Customer instance with provided attributes' do
    engine.customers.create({
      :first_name => "Monty",
      :last_name  => "Python"
    })

    expect(engine.customers.all.last.first_name).to eq ("Monty")
    expect(engine.customers.all.last.last_name).to eq ("Python")
    expect(engine.customers.all.last.id).to eq (1001)
  end
  
  # update(id, attribute) - update the Customer instance with the corresponding id with the provided attributes. Only the customer’s first_name and last_name can be updated. This method will also change the customer’s updated_at attribute to the current time.
  it 'updates customer last name and updated at time of provided id' do 
    expect(engine.customers.find_by_id(999).updated_at).to eq Time.parse("2012-03-27 14:58:15 UTC")
    expect(engine.customers.find_by_id(999).first_name).to eq ("Clementina")
    expect(engine.customers.find_by_id(999).last_name).to eq ("Hudson")

    time_current = engine.customers.find_by_id(999).updated_at

    engine.customers.update(999, {first_name: "Dennis", last_name: "Rodman"})

    expect(engine.customers.find_by_id(999).first_name).to eq ("Dennis")
    expect(engine.customers.find_by_id(999).last_name).to eq ("Rodman")
    expect(engine.customers.find_by_id(999).updated_at).to be > (time_current)
  end
  #delete(id) - delete the Customer instance with the corresponding id
  it 'deletes a Customer instance with provided id' do
    expect(engine.customers.all.last.last_name).to eq ("Python")
    engine.customers.delete(1001)
    expect(engine.customers.find_by_id(1001)).to eq(nil)
  end
end