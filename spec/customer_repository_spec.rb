require 'rspec'
require './lib/customer_repository'
require './lib/sales_engine'
require 'simplecov'
SimpleCov.start

RSpec.describe CustomerRepository do
  before(:each) do
    @se = SalesEngine.from_csv({
      :items => './spec/fixtures/item_mock.csv',
      :merchants => './spec/fixtures/merchant_mock.csv',
      :invoices => './spec/fixtures/invoices_mock.csv',
      :invoice_items => './spec/fixtures/invoice_items_mock.csv',
      :customers => './spec/fixtures/customers_mock.csv',
      :transactions => './spec/fixtures/transactions_mock.csv'})
    @cr = CustomerRepository.new('./spec/fixtures/customers_mock.csv', @se)
  end

  describe 'instantiation' do
    it 'exists' do

      expect(@cr).to be_an_instance_of(CustomerRepository)
    end

    it 'has readable attributes' do

      expect(@cr.customers.count).to eq(0)
      expect(@cr.customers).to eq([])

      @cr.create_repo

      expect(@cr.customers.count).to eq(15)
      expect(@cr.customers[0].id).to eq(1)

    end
  end

  describe 'has a method that can' do
    it 'can create a repo' do
      expect(@cr.customers.count).to eq(0)
      expect(@cr.customers).to eq([])

      @cr.create_repo

      expect(@cr.customers.count).to eq(15)
      expect(@cr.customers[0].id).to eq(1)
    end

    it 'can return all customers' do
      @cr.create_repo

      expect(@cr.all.count).to eq(15)
    end

    it 'can find customers by customer id' do
      @cr.create_repo

      expect(@cr.find_by_id(1)).to be_an_instance_of(Customer)
      expect(@cr.find_by_id(2).id).to eq(2)
    end

    it 'can find all customers by first name' do
      @cr.create_repo

      expect(@cr.find_all_by_first_name("Joey").count).to eq(1)
      expect(@cr.find_all_by_first_name("Cecelia").count).to eq(1)

    end

    it 'can find all customers by last name' do
      @cr.create_repo

      expect(@cr.find_all_by_last_name("Ondricka").count).to eq(1)
      expect(@cr.find_all_by_last_name("Osinski").count).to eq(1)

    end

    it 'can create new customers' do
      @cr.create_repo
      expect(@cr.all.count).to eq(15)

      @cr.create({
                  id: 16,
                  created_at: Time.now.strftime("%Y-%m-%d"),
                  updated_at: Time.now.strftime("%Y-%m-%d")
                  })

      expect(@cr.all.count).to eq(16)
      expect(@cr.all.last.id).to eq(16)
    end

    it 'can update existing customers' do
      @cr.create_repo
      expect(@cr.find_by_id(15).first_name).to eq('Magnus')
      @cr.update(15, {first_name: 'RickyBobby'})
      expect(@cr.find_by_id(15).first_name).to eq('RickyBobby')

      @cr.update(15, {last_name: 'TigerKing'})

      expect(@cr.find_by_id(15).last_name).to eq('TigerKing')
    end

    it 'can delete by id' do
      @cr.create_repo
      expect(@cr.all.count).to eq(15)
      expect(@cr.all.last.id).to eq(15)

      @cr.delete(15)

      expect(@cr.all.count).to eq(14)
      expect(@cr.all.last.id).to eq(14)
    end
  end
end
