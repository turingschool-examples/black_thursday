require 'time'
require './lib/sales_engine'
require './lib/customer_repository'

RSpec.describe CustomerRepository do
  let(:cr) { CustomerRepository.new }

  let(:customer1) { cr.create({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Smith",
    :created_at => Time.now,
    :updated_at => Time.now
    })}

  let(:customer2) { cr.create({
    :id => NIL,
    :first_name => "Bob",
    :last_name => "Vance",
    :created_at => Time.now,
    :updated_at => Time.now
    })}

    let(:customer3) { cr.create({
      :id => NIL,
      :first_name => "Bob",
      :last_name => "Smith",
      :created_at => Time.now,
      :updated_at => Time.now
      })}

  it 'creates instances Customer, id + 1' do
  
    expect(customer1).to be_a(Customer)
    expect(customer2).to be_a(Customer)
    expect(customer2.id).to eq(7)
  end

  it 'lists all instance of customer' do
    
    expect(cr.all).to eq([customer1, customer2, customer3])
  end

  it 'finds Customer by id' do

    expect(customer1.id).to eq(6)
    expect(cr.find_by_id(6)).to eq(customer1)
  end

  it 'finds all Customers by first name' do
   
    expect(cr.all).to eq([customer1, customer2, customer3])
    expect(cr.find_all_by_first_name("ob")).to eq([customer2, customer3])
  end

  it 'finds Customers by last name' do

    expect(cr.all).to eq([customer1, customer2, customer3])
    expect(cr.find_all_by_last_name("smith")).to eq([customer1, customer3])
  end

  it 'updates first and last name, updated at time' do
    
    expect(customer1.first_name).to eq("Joan")
    expect(customer1.last_name).to eq("Smith")

    expect(cr.update(6, {
      :id => NIL,
      :first_name => "Jim",
      :last_name => "Jones",
      :created_at => Time.now,
      :updated_at => Time.now
      }))
    
    expect(customer1.id).to eq(6)
    expect(customer1.first_name).to eq("Jim")
    expect(customer1.last_name).to eq("Jones")
  end

  it 'deletes by id' do
  
    expect(cr.all).to eq([customer1, customer2, customer3])
    cr.delete(6)
    expect(cr.all).to eq([customer2, customer3])
  
  end
end