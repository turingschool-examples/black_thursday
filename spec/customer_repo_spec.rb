require 'CSV'
require 'sales_engine'
require 'customer_repo'

RSpec.describe CustomerRepo do
  describe 'instantiation' do
    it'::new' do
      mock_engine = double('CustomerRepo')
      customer_repo = CustomerRepo.new('./fixtures/mock_customers.csv', mock_engine)

      expect(customer_repo).to be_an_instance_of(CustomerRepo)
    end

    it'has attributes' do
      mock_engine = double('CustomerRepo')
      customer_repo = CustomerRepo.new('./fixtures/mock_customers.csv', mock_engine)

      expect(customer_repo.customers).to be_an_instance_of(Array)
    end
  end

  describe '#methods' do

    it'#all' do
      mock_engine = double('CustomerRepo')
      customer_repo = CustomerRepo.new('./fixtures/mock_customers.csv', mock_engine)

      expect(customer_repo.all).to be_an_instance_of(Array)
    end

    xit'#find by id' do
      mock_engine = double('CustomerRepo')
      customer_repo = CustomerRepo.new('./fixtures/mock_customers.csv', mock_engine)
      collection = customer_repo.customers
      customer1 = customer_repo.create({:id => 6,
                                        :first_name => "Joan",
                                        :last_name => "Clarke",
                                        :created_at => Time.now,
                                        :updated_at => Time.now
                                      })

      expect(customer_repo.find_by_id(customer1.id, collection)).to eq(transaction1)
      expect(customer_repo.find_by_id(999999999, collection)).to eq(nil)
    end

    xit'#find all by first name' do
      mock_engine = double('CustomerRepo')
      customer_repo = CustomerRepo.new('./fixtures/mock_customers.csv', mock_engine)
      collection = customer_repo.customers
      customer1 = customer_repo.create({:id => 6,
                                        :first_name => "Joan",
                                        :last_name => "Clarke",
                                        :created_at => Time.now,
                                        :updated_at => Time.now
                                      })
      fragment = "JoA"
      expected = customer_repo.find_by_first_name(fragment)

      expect(expected).to eq([customer1])
      expect(expected.length).to eq(4)
      expect(expected.first.class).to eq(Customer)
      expect(customer_repo.find_by_first_name("doge")).to eq([])
    end

    xit'#find all by last name' do
      mock_engine = double('CustomerRepo')
      customer_repo = CustomerRepo.new('./fixtures/mock_customers.csv', mock_engine)
      collection = customer_repo.customers
      customer1 = customer_repo.create({:id => 6,
                                        :first_name => "Joan",
                                        :last_name => "Clarke",
                                        :created_at => Time.now,
                                        :updated_at => Time.now
                                      })

      fragment = "arKe" #test case sensitive
      expected = customer_repo.find_by_last_name(fragment)

      expect(expected).to eq([customer1])
      expect(expected.length).to eq(6)
      expect(expected.first.class).to eq(Customer)
      expect(customer_repo.find_by_last_name("doge")).to eq([])
    end

    xit'# creates a new customer instance' do
      mock_engine = double('CustomerRepo')
      customer_repo = CustomerRepo.new('./fixtures/mock_customers.csv', mock_engine)
      collection = customer_repo.customers
      customer1 = customer_repo.create({:id => 6,
                                        :first_name => "Joan",
                                        :last_name => "Clarke",
                                        :created_at => Time.now,
                                        :updated_at => Time.now
                                      })
      customer_repo.all
      expected = customer_repo.create(customer1)

      expect(expected).to be_an_instance_of(Customer)
      expect(expected.last_name).to eq("Clarke")
    end

    xit'#updates attributes' do
      mock_engine = double('CustomerRepo')
      customer_repo = CustomerRepo.new('./fixtures/mock_customers.csv', mock_engine)
      customer1 = customer_repo.create({ :id => 6,
                                         :first_name => "Joan",
                                         :last_name => "Clarke",
                                         :created_at => Time.now,
                                         :updated_at => Time.now
                                      })
      customer_repo.add_customer(customer1)

      updated_attributes = ({ :first_name => "Alan",
                              :last_name => "Turing",
                              :updated_at => Time.now
                            })

      expect(customer1.first_name).to eq("Alan")
      expect(customer1.last_name).to eq("Turing")
      expect(customer1.updated_at).to be_an_instance_of(Time)
    end

    xit'#deletes by id' do
      mock_engine = double('CustomerRepo')
      customer_repo = CustomerRepo.new('./fixtures/mock_customers.csv', mock_engine)
      customer1 = customer_repo.create({ :id => 6,
                                         :first_name => "Joan",
                                         :last_name => "Clarke",
                                         :created_at => Time.now,
                                         :updated_at => Time.now
                                      })

      customer_repo.add_transaction(customer1)

      expect(customer_repo.find_by_id(6)).to eq(customer1)

      customer_repo.delete(6)

      expect(customer1.find_by_id(6)).to eq(nil)
    end
  end
end
