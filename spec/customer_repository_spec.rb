require 'SimpleCOV'
require 'csv'
require './lib/customer_repository'
require './lib/sales_engine'

RSpec.describe CustomerRepository do

  describe 'initialize' do
    it 'exists' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        customers: './data/customers.csv'
      )

      cr = se.customers

      expect(cr).to be_an_instance_of(CustomerRepository)
    end
  end

  describe '#all_customers' do
    it 'creates an array of customers' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        customers: './data/customers.csv'
      )

      cr = se.customers

      expect(cr.all[1].first_name).to eq('Cecelia')
    end
  end

  describe '#find_all_by_first_name' do
    it 'finds all with that first name' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        customers: './data/customers.csv'
      )

      cr = se.customers

      expect(cr.find_all_by_first_name('Joey')[0].last_name).to eq('Ondricka')
    end
  end

  describe '#find_all_by_last_name' do
    it 'finds all with same last name' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        customers: './data/customers.csv'
      )

      cr = se.customers

      expect(cr.find_all_by_last_name('Ondricka')[0].first_name).to eq('Joey')
    end
  end

  describe '#create' do
    it 'creates a new customer' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        customers: './data/customers.csv'
      )

      cr = se.customers

      attributes = {
        first_name: 'Lando',
        last_name: 'Calrissian'
      }

      expect(cr.create(attributes)).to be_an_instance_of(Customer)
    end
  end

  describe '#update' do
    it 'updates the first_name' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        customers: './data/customers.csv'
      )

      cr = se.customers

      cr.update(1, first_name: 'Lando')

      expect(cr.find_by_id(1).first_name).to eq('Lando')
    end

    it 'updates last name' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        customers: './data/customers.csv'
       )

      cr = se.customers

      cr.update(1, last_name: 'Lando')

      expect(cr.find_by_id(1).last_name).to eq('Lando')
    end

    it 'doesnt update if id does not exist' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        customers: './data/customers.csv'
       )

      cr = se.customers

      expect(cr.update(1920183749120, first_name: 'Lando')).to eq(nil)
    end
  end

  describe '#all' do
      it 'returns an array of all customers' do
        se = SalesEngine.from_csv(
          items: './data/items.csv',
          merchants: './data/merchants.csv',
          customers: './data/customers.csv'
        )

        cr = se.customers

      expect(cr.all[1].first_name).to eq('Cecelia')
    end
  end

  describe 'find_by_id' do
    it 'finds customer by given id' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        customers: './data/customers.csv'
      )

      cr = se.customers

      expect(cr.find_by_id(1).first_name).to eq('Joey')
    end
  end

  describe '#delete' do
    it 'deletes a customer with given id' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        customers: './data/customers.csv'
      )

      cr = se.customers

      cr.delete(1)

      expect(cr.find_by_id(1)).to eq(nil)
    end
  end
end
