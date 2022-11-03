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

  it 'has a method to create a new customer and have their id number be correct' do
    cust_repo.all.push(cust1)
    cust_repo.create({:first_name => "Sally",
                      :last_name => "Sue"
                    })

    expect(cust_repo.all[1]).to be_a(Customer)
    expect(cust_repo.all[1].first_name).to eq("Sally")
    expect(cust_repo.all[1].last_name).to eq("Sue")
    expect(cust_repo.all[1].id).to eq(4)

    cust_repo.push(cust2)
    cust_repo.create({:first_name => "Bobby",
                      :last_name => "Bob"
                    })

    expect(cust_repo.all[3]).to be_a(Customer)
    expect(cust_repo.all[3].first_name).to eq("Bobby")
    expect(cust_repo.all[3].last_name).to eq("Bob")
    expect(cust_repo.all[3].id).to eq(46)
  end

  it 'has a method to update the customers first and last names, and auto change the updated_at' do
    cust_repo.push(cust2)
    cust_repo.update(45, {:first_name => "Amy",
                          :last_name  => "Ellen"})

    expect(cust_repo.all[0].first_name).to eq("Amy")
    expect(cust_repo.all[0].last_name).to eq("Ellen")
    expect(cust_repo.all[0].id).to eq(45)
  end
end