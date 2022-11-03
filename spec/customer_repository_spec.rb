require './lib/customer_repository'
require './lib/customer'

RSpec.describe CustomerRepository do
  let(:cust_repo) {CustomerRepository.new}
  let(:cust1) {Customer.new({
                              :id         => 3,
                              :first_name => "Jimmy",
                              :last_name  => "John",
                              :created_at => Time.now,
                              :updated_at => Time.now
                            })}
  let(:cust2) {Customer.new({
                              :id         => 45,
                              :first_name => "Jane",
                              :last_name  => "John",
                              :created_at => Time.now,
                              :updated_at => Time.now
                            })}

  it 'is a customer repository and stores an array of customers' do
    expect(cust_repo).to be_a(CustomerRepository)
    expect(cust_repo.all).to eq([])
  end

  it 'has a method to find a customer by their id' do
    cust_repo.all.push(cust1)
    cust_repo.all.push(cust2)
    
    expect(cust_repo.all).to eq([cust1, cust2])
    expect(cust_repo.find_by_id(3)).to eq(cust1)
    expect(cust_repo.find_by_id(45)).to eq(cust2)
    expect(cust_repo.find_by_id(2)).to eq(nil)
  end

  it 'has a method to find all customers by first name' do
    cust_repo.all.push(cust1)
    cust_repo.all.push(cust2)
    
    expect(cust_repo.find_all_by_first_name("Jimmy")).to eq([cust1])
    expect(cust_repo.find_all_by_first_name("Jane")).to eq([cust2])
    expect(cust_repo.find_all_by_first_name("Bob")).to eq([])
  end

  it 'has a method to find all customers by last name' do
    cust_repo.all.push(cust1)
    cust_repo.all.push(cust2)

    expect(cust_repo.find_all_by_last_name("John")).to eq([cust1, cust2])
    expect(cust_repo.find_all_by_last_name("Billy")). to eq([])
  end

end