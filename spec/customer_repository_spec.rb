require './lib/customer'
require './lib/customer_repository'
require 'Timecop'

RSpec.describe do
  it 'exists' do
    customer_path = './data/customers.csv'
    customer_repository = CustomerRepository.new(customer_path)

    expect(customer_repository).to be_an_instance_of(CustomerRepository)
  end

  it 'can return an array of all known customers' do
    customer_path = './data/customers.csv'
    customer_repository = CustomerRepository.new(customer_path)
    expect(customer_repository.all[0]).to be_an_instance_of(Customer)
    expect(customer_repository.all.count).to eq(1000)
  end

  it 'can find customer by id' do
    customer_path = './data/customers.csv'
    customer_repository = CustomerRepository.new(customer_path)
    example_customer = customer_repository.all[25]
    expect(customer_repository.find_by_id(example_customer.id)).to eq(example_customer)
    expect(customer_repository.find_by_id(999999)).to eq nil
  end

  it 'can find merchants by first name' do
    customer_path = './data/customers.csv'
    customer_repository = CustomerRepository.new(customer_path)
    example_customer = customer_repository.all[25]
    expect(customer_repository.find_all_by_first_name("Porky")).to eq(nil)
    expect(customer_repository.find_all_by_first_name("Porky")).to eq(nil)
  end

  it 'can find merchants by last name' do
    customer_path = './data/customers.csv'
    customer_repository = CustomerRepository.new(customer_path)
    example_customer = customer_repository.all[25]
    expect(customer_repository.find_all_by_last_name("Porky")).to eq(nil)
    expect(customer_repository.find_all_by_last_name("Porky")).to eq(nil)
  end

  it 'can create a customer with given attributes' do
    customer_path = './data/customers.csv'
    customer_repository = CustomerRepository.new(customer_path)
    expect(customer_repository.find_by_id(1001)).to eq(nil)
    customer_repository.create({
                        :id => 1001,
                        :first_name => "Joan",
                        :last_name => "Clarke",
                        :created_at => Time.now,
                        :updated_at => Time.now
                      })
    expect(customer_repository.find_by_id(1001)).not_to eq(nil)
    expect(customer_repository.all.last.id).to eq(1001)
  end

  before do
    Timecop.freeze(Time.local(1990))
  end

  it 'can update customer attributes using ID' do
    customer_path = './data/customers.csv'
    customer_repository = CustomerRepository.new(customer_path)
    customer_repository.create({
                                :id => 1001,
                                :first_name => "Joan",
                                :last_name => "Clarke",
                                :created_at => Time.now,
                                :updated_at => "1989-01-01 00:00:00 -0700"
                              })

    expect(customer_repository.find_by_id(1001).updated_at).to eq("1989-01-01 00:00:00 -0700")
    customer_repository.update(1001, "Brooke", "Shields")
    expect((customer_repository.find_by_id(1001)).first_name).to eq("Brooke")
    expect((customer_repository.find_by_id(1001)).last_name).to eq("Shields")
  end
  
  after do
    Timecop.return
  end

  it 'can delete a customer by ID' do
    customer_path = './data/customers.csv'
    customer_repository = CustomerRepository.new(customer_path)
    customer_repository.create(:first_name => "Garth", :last_name => "Wayne", :id => 1001)
    expect(customer_repository.all.count).to eq(1001)
    customer_repository.delete(1001)
    expect(customer_repository.all.count).to eq(1000)
   end
end
