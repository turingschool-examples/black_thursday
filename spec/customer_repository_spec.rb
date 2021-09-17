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
    expect(@cus.find_all_by_first_name('jon')).to eq(2)
    expect(@cus.find_all_by_first_name('geo')).to eq(5)
  end

  it '#find_all_by_last_name' do
    expect(@cus.find_all_by_las_name('emm')).to eq(2)
  end
end
