require 'CSV'
require './lib/sales_engine'
require './lib/invoice_repo'
require './lib/invoice'
require './lib/invoice_item_repo'
require './lib/invoice_item'
require './lib/transaction_repo'
require './lib/transaction'
require './lib/customer_repo'
require './lib/customer'

RSpec.describe CustomerRepo do
  before(:each) do
    @sales_engine = SalesEngine.from_csv({:items => './data/items.csv',
                                         :merchants => './data/merchants.csv',
                                         :invoices => "./data/invoices.csv",
                                         :invoice_items => "./data/invoice_items.csv",
                                         :transactions => "./data/transactions.csv",
                                         :customers => "./data/customers.csv"})
  end

  describe 'instantiation' do
    it '::new' do
      customer_repo = @sales_engine.customers

      expect(customer_repo).to be_an_instance_of(CustomerRepo)
    end

    it 'has attributes' do
      customer_repo = @sales_engine.customers

      expect(customer_repo.customers).to be_an_instance_of(Array)
    end
  end

  describe '#methods' do

    it '#all' do
      customer_repo = @sales_engine.customers

      expect(customer_repo.all).to be_an_instance_of(Array)
    end

    it '#find by id' do
      customer_repo = @sales_engine.customers
      customer1 = customer_repo.create({:id => 6,
                                        :first_name => "Joan",
                                        :last_name => "Clarke",
                                        :created_at => Time.now,
                                        :updated_at => Time.now
                                      })

      expect(customer_repo.find_by_id(customer1.id)).to eq(transaction1)
      expect(customer_repo.find_by_id(999999999)).to eq(nil)
    end

    it '#find by first name' do
      customer_repo = @sales_engine.customers
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

    it '#find by last name' do
      customer_repo = @sales_engine.customers
      customer1 = customer_repo.create({:id => 6,
                                        :first_name => "Joan",
                                        :last_name => "Clarke",
                                        :created_at => Time.now,
                                        :updated_at => Time.now
                                      })
      fragment = "arKe"
      expected = customer_repo.find_by_last_name(fragment)

      expect(expected).to eq([customer1])
      expect(expected.length).to eq(6)
      expect(expected.first.class).to eq(Customer)
      expect(customer_repo.find_by_last_name("doge")).to eq([])
    end

  end


end
