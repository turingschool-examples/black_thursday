require_relative 'spec_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'

RSpec.describe CustomerRepository do
  before :each do
    @repo = CustomerRepository.new('./spec/fixtures/mock_customers.csv')
  end

  it 'exists' do
    expect(@repo).to be_an_instance_of(CustomerRepository)
  end

  it 'can create customer instances' do
    @repo.all.each do |customer|
      expect(customer).to be_a(Customer)
    end
  end

  it 'can find customer by id' do
    expect(@repo.find_by_id(1).first_name).to eq("Joey")
    expect(@repo.find_by_id(2).first_name).to eq("Cecelia")
    expect(@repo.find_by_id(33)).to eq(nil)
  end

  it 'can find customers by first name' do
    expect(@repo.find_all_by_first_name("Joey")[0].id).to eq(1)
  end

  it 'can find customer by last name' do
    expect(@repo.find_all_by_last_name("Toy")[0].id).to eq(3)
  end

  it 'can create a new customer' do
    attributes = {
      :id => 25,
      :first_name => "Joan",
      :last_name => "Clarke",
    }
    @repo.create(attributes)

    expect(@repo.all.length).to eq(4)
    expect(@repo.all.last.id).to eq(4)
  end

  it 'can update customer' do
    attributes = {
      :id => 25,
      :first_name => "Joan",
      :last_name => "Clarke",
    }
  @repo.update(33, attributes)

  expect(@repo.all.length).to eq(3)
  expect(@repo.update(377, attributes)).to eq(nil)
  end

  it 'can delete a customer' do
    @repo.delete(1)

    expect(@repo.all.length).to eq(2)
  end
end
