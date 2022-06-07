require 'csv'
require 'customer'
require 'customer_repository'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'

RSpec.describe CustomerRepository do
  before :each do
    @customer_repository = CustomerRepository.new("./data/customers.csv")
  end

  it 'exists' do
    expect(@customer_repository).to be_a CustomerRepository
  end

  it 'can find a customer by id and return nil if no customer is found' do
    expect(@customer_repository.find_by_id(0)).to eq nil
    expect(@customer_repository.find_by_id(1)).to be_a(Customer)
    expect(@customer_repository.find_by_id(1000)).to be_a(Customer)
  end

  it 'can find all customers by first name' do
    result_1 = @customer_repository.find_all_by_first_name("Samara")
    result_2 = @customer_repository.find_all_by_first_name("NO")
    expect(result_1).to be_a(Array)
    expect(result_1[0].first_name).to eq("Samara")
    expect(result_2).to be_a(Array)
    expect(result_2.count).to eq(21)
  end

  it 'can find all customers by last name' do
    result_1 = @customer_repository.find_all_by_last_name("Hyatt")
    result_2 = @customer_repository.find_all_by_last_name("JO")
    expect(result_1).to be_a(Array)
    expect(result_1[0].last_name).to eq("Hyatt")
    expect(result_2).to be_a(Array)
    expect(result_2.count).to eq(5)
  end

  it 'can create new customers' do
    @customer_repository.create({:id => 1001, :first_name => "Bryan", :last_name => "Shears", :created_at => Time.now, :updated_at => Time.now})
    expect(@customer_repository.all.last).to be_a(Customer)
    expect(@customer_repository.all.length).to eq(1001)
    expect(@customer_repository.all.last.id).to eq(1001)
  end

  it 'can update the customer instance with corresponding id' do
    @customer_repository.update(1000, {:first_name => "test_1", :last_name => "test_2"})
    expect(@customer_repository.all.last.id.to_i).to eq(1000)
    expect(@customer_repository.find_by_id(1000).first_name).to eq("test_1")
    expect(@customer_repository.find_by_id(1000).last_name).to eq("test_2")
  end

  it 'can delete the customer by id' do
    @customer_repository.delete(1)
    expect(@customer_repository.all.first.id.to_i).to eq(2)
  end

end
