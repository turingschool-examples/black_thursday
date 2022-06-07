require 'rspec'
require './lib/customer'
require './lib/customer_repository'

RSpec.describe CustomerRepository do
  describe 'Iteration 3' do
    before :each do
      @cr = CustomerRepository.new('./data/customers.csv')
      @test_attributes = {:id => 1053,
                          :first_name => "Ernie",
                          :last_name => "Wigglesworth",
                          :created_at => Time.now,
                          :updated_at => Time.now
                        }
      @c = {
          :id => 6,
          :first_name => "Randi",
          :last_name => "Smithsonian",
          :created_at => Time.now,
          :updated_at => Time.now
        }
    end

    it 'exists' do
      expect(@cr).to be_a(CustomerRepository)
    end

    it "can return an array of all customer instances" do
      expect(@cr.all).to be_a(Array)
      expect(@cr.all).to include(Customer)
    end

    it "can find by id" do
      expect(@cr.find_by_id(1)).to be_a(Customer)
      # expect(@cr.find_by_id(1001).first_name).to be_nil
    end

    it "can find all by first name" do
      expect(@cr.find_all_by_first_name("Sylvester")).to be_a(Array)
      expect(@cr.find_all_by_first_name("Sylvester").count).to eq(2)
      expect(@cr.find_all_by_first_name("Joey")).to be_a(Array)
      expect(@cr.find_all_by_first_name("Joey").count).to eq(1)
    end

    it "can find all by last name" do
      expect(@cr.find_all_by_last_name("Toy")).to be_a(Array)
      expect(@cr.find_all_by_last_name("Toy").count).to eq(2)
      expect(@cr.find_all_by_last_name("Braun")).to be_a(Array)
      expect(@cr.find_all_by_last_name("Braun").count).to eq(3)
    end

    it "can create a new customer" do
      expect(@cr.find_by_id(1001)).to be_nil
      expect(@cr.find_all_by_last_name("Smithsonian").count).to eq(0)

      @cr.create(@c)

      expect(@cr.find_all_by_first_name("Sylvester").length).to eq(2)
      expect(@cr.find_by_id(1001)).to be_a(Customer)
      expect(@cr.find_by_id(1001).first_name).to eq("Randi")
    end

    it "can update customer attributes" do
      @cr.create(@c)

      expect(@cr.find_by_id(1001).first_name).to eq("Randi")
      expect(@cr.find_all_by_first_name("Randi").count).to eq(1)
      expect(@cr.find_all_by_first_name("Ernie").count).to eq(0)

      @cr.update(1001, @test_attributes)

      expect(@cr.find_all_by_first_name("Randi").count).to eq(0)
      expect(@cr.find_all_by_first_name("Ernie").count).to eq(1)
      expect(@cr.find_by_id(1001)).to be_a(Customer)
      expect(@cr.find_by_id(1001).last_name).to eq("Wigglesworth")
    end

    it "can delete customer instance (by id)" do


      @cr.create(@c)

      expect(@cr.find_all_by_first_name("Randi").count).to eq(1)
      expect(@cr.find_by_id(1001).first_name).to eq("Randi")

      @cr.delete(1001)

      expect(@cr.find_all_by_first_name("Randi").count).to eq(0)
    end
  end
end
