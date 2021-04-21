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

    it'#find by id' do
      mock_engine = double('CustomerRepo')
      customer_repo = CustomerRepo.new('./fixtures/mock_customers.csv', mock_engine)
      collection = customer_repo.customers
      customer = customer_repo.create({:id => 6,
                                        :first_name => "Joan",
                                        :last_name => "Clarke",
                                        :created_at => Time.now,
                                        :updated_at => Time.now
                                      })

      expect(customer_repo.find_by_id(customer.id, collection)).to eq(customer)
      expect(customer_repo.find_by_id(999999999, collection)).to eq(nil)
    end

    it'#find all by first name' do
      mock_engine = double('CustomerRepo')
      customer_repo = CustomerRepo.new('./fixtures/mock_customers.csv', mock_engine)
      collection = customer_repo.customers
      customer = customer_repo.create({:id => 6,
                                        :first_name => "Joan",
                                        :last_name => "Clarke",
                                        :created_at => Time.now,
                                        :updated_at => Time.now
                                      })
                                      
      fragment = "JoA"
      expected = customer_repo.find_all_by_first_name(fragment, collection)

      expect(expected).to eq([customer])
      expect(expected.length).to eq(4)
      expect(expected.first.class).to eq(Customer)
      expect(customer_repo.find_by_first_name("doge")).to eq([])
    end

    it'#find all by last name' do
      mock_engine = double('CustomerRepo')
      customer_repo = CustomerRepo.new('./fixtures/mock_customers.csv', mock_engine)
      collection = customer_repo.customers
      customer = customer_repo.create({:id => 6,
                                       :first_name => "Joan",
                                       :last_name => "Clarke",
                                       :created_at => Time.now,
                                       :updated_at => Time.now})

      fragment = "arKe" #test case sensitive
      expected = customer_repo.find_all_by_last_name(fragment, collection)

      expect(expected).to eq([customer])
      expect(expected.length).to eq(6)
      expect(expected.first.class).to eq(Customer)
      expect(customer_repo.find_by_last_name("doge")).to eq([])
    end

    it'#create' do
      mock_engine = double('CustomerRepo')
      customer_repo = CustomerRepo.new('./fixtures/mock_customers.csv', mock_engine)
      collection = customer_repo.customers
      customer = customer_repo.create({:id => 6,
                                       :first_name => "Joan",
                                       :last_name => "Clarke",
                                       :created_at => Time.now,
                                       :updated_at => Time.now})

      expect(customer).to be_an_instance_of(Customer)
      expect(customer.last_name).to eq("Clarke")
    end

    it'#updates attributes' do
      mock_engine = double('CustomerRepo')
      customer_repo = CustomerRepo.new('./fixtures/mock_customers.csv', mock_engine)
      customer = customer_repo.create({ :id => 6,
                                        :first_name => "Joan",
                                        :last_name => "Clarke",
                                        :created_at => Time.now,
                                        :updated_at => Time.now
                                      })
                                      
      updated_attributes = {:first_name => 'Alan'}      

      customer_repo.update(customer.id, updated_attributes)

      expect(customer.first_name).to eq("Alan")
      expect(customer.updated_at).to be_an_instance_of(Time)
    end

    it'#deletes by id' do
      mock_engine = double('CustomerRepo')
      customer_repo = CustomerRepo.new('./fixtures/mock_customers.csv', mock_engine)
      customer = customer_repo.create({ :id => 6,
                                         :first_name => "Joan",
                                         :last_name => "Clarke",
                                         :created_at => Time.now,
                                         :updated_at => Time.now
                                      })

      expect(customer_repo.all.length).to eq(11)

      customer_repo.delete(customer.id)

      expect(customer_repo.all.length).to eq(10)
    end
  end
end
