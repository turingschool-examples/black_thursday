require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/customer_repository'

RSpec.describe CustomerRepository do
  describe '#initialize' do
    it 'exists' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_data = './spec/truncated_data/customers_truncated.csv'
      cr = CustomerRepository.new(truncated_data, mock_sales_engine)

      expect(cr).to be_a(CustomerRepository)
    end

    it 'has customers' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_data = './spec/truncated_data/customers_truncated.csv'
      cr = CustomerRepository.new(truncated_data, mock_sales_engine)

      expect(cr.customers[0]).to be_a(Customer)
    end
  end

  describe '#all' do
    it 'returns all customers' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_data = './spec/truncated_data/customers_truncated.csv'
      cr = CustomerRepository.new(truncated_data, mock_sales_engine)

      expect(cr.all).to be_a(Array)
      expect(cr.all.count).to eq(12)
      expect(cr.all[0]).to be_a(Customer)
    end
  end

  describe '#find_by_id' do
    it 'finds by id or returns nil' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_data = './spec/truncated_data/customers_truncated.csv'
      cr = CustomerRepository.new(truncated_data, mock_sales_engine)

      expect(cr.find_by_id(14)).to eq(nil)
      expect(cr.find_by_id(1)).to eq(cr.customers[0])
    end
  end

  describe '#find_all_by_first_name' do
    it 'returns array of all first name matches' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_data = './spec/truncated_data/customers_truncated.csv'
      cr = CustomerRepository.new(truncated_data, mock_sales_engine)

      expect(cr.find_all_by_first_name('Ji')).to eq([])
      expect(cr.find_all_by_first_name('Ce')).to eq([cr.customers[1]])
      expect(cr.find_all_by_first_name('Joey')).to eq([cr.customers[0],
                                                       cr.customers[6]])
    end
  end

  describe '#find_all_by_last_name' do
    it 'returns array of all last name matches' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_data = './spec/truncated_data/customers_truncated.csv'
      cr = CustomerRepository.new(truncated_data, mock_sales_engine)

      expect(cr.find_all_by_first_name('Peterson')).to eq([])
      expect(cr.find_all_by_last_name('Ondricka')).to eq([cr.customers[0]])
      expect(cr.find_all_by_last_name('Braun')).to eq([cr.customers[3],
                                                       cr.customers[8]])
    end
  end

  describe '#create' do
    it 'creates a new customer with their id one higher than the highest' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_data = './spec/truncated_data/customers_truncated.csv'
      cr = CustomerRepository.new(truncated_data, mock_sales_engine)
      attributes = {
        first_name: 'Jimmy',
        last_name: 'Johns',
        created_at: '2012-03-27 14:54:10 UTC',
        updated_at: '2012-03-27 14:54:12 UTC'
      }
      cr.create(attributes)
      expected = cr.find_by_id(13)
      expect(expected.first_name).to eq('Jimmy')
    end
  end

  describe '#update' do
    it 'can update the customers name and updated at time' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_data = './spec/truncated_data/customers_truncated.csv'
      cr = CustomerRepository.new(truncated_data, mock_sales_engine)

      attributes = {
        first_name: 'Jimmy',
        last_name: 'Johns'
      }

      cr.update(1, attributes)

      expect(cr.customers[0].first_name).to eq('Jimmy')
      expect(cr.customers[0].last_name).to eq('Johns')
      expect(cr.customers[0].created_at.year).to eq(2012)
      expect(cr.customers[0].updated_at.year).to eq(2021)
    end
  end

  describe '#delete' do
    it 'can delete customer with given id' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_data = './spec/truncated_data/customers_truncated.csv'
      cr = CustomerRepository.new(truncated_data, mock_sales_engine)

      cr.delete(1)
      expect(cr.find_by_id(1)).to eq(nil)
    end
  end
end