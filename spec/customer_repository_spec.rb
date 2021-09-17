require 'rspec'
require './lib/customer'
require './lib/customer_repository'

RSpec.describe CustomerRepository do

  before (:each) do

    @path = './data/customers.csv'
    @cus = CustomerRepository.new(@path)

  end

  it 'exists' do
    expect(@cus).to be_an_instance_of CustomerRepository
    expect(@cus.all).to be_an Array
    expect(@cus.all[0].id).to eq(1)
    expect(@cus.all[0].first_name).to eq("Joey")
  end

  it '#find_by_id' do
    expect(@cus.find_by_id(2)).to be_an_instance_of Customer
    expect(@cus.find_by_id(0)).to be nil
  end

  it '#find_all_by_first_name' do
    expect(@cus.find_all_by_first_name('jon')).to be_an Array
    expect(@cus.find_all_by_first_name('geo').count).to eq(5)
  end

  it '#find_all_by_last_name' do
    expect(@cus.find_all_by_last_name('emm').count).to eq(2)
    expect(@cus.find_all_by_last_name('Jeon')).to eq([])
  end

  it '#create' do
    attribute1 = {first_name: 'Haewon',last_name: 'Jeon'}
    customer1 = @cus.create(attribute1)

    expect(customer1).to be_an_instance_of Customer
    expect(customer1.id).to eq(1001)
    expect(customer1.first_name).to eq('Haewon')
    expect(customer1.last_name).to eq('Jeon')
  end

  it '#update' do
    id = 100
    attributes = {first_name: 'John', last_name: 'Morris'}
    updated = @cus.update(id, attributes)

    expect(updated.first_name).to eq('John')
    expect(updated.last_name).to eq('Morris')
    expect(updated.id).to eq(100)
    expect(updated.first_name).to_not eq("Genoveva")
  end

  it '#delete' do
    id = 200
    deleted_customer = @cus.find_by_id(200)
    @cus.delete(200)

    expect(@cus.all).not_to include(deleted_customer)
  end
end
