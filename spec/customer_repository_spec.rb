# frozen_string_literal: true

require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

RSpec.describe 'Iteration 3' do
  context 'CustomerRepository' do
    before(:each) do
      @se = SalesEngine.from_csv({
                                   items: './data/items.csv',
                                   merchants: './data/merchants.csv',
                                   invoices: './data/invoices.csv',
                                   transactions: './data/transactions.csv',
                                   customers: './data/customers.csv',
                                   invoice_items: './data/invoice_items.csv'
                                 })
    end

    it 'all returns all customers' do
      expected = @se.customers.all
      expect(expected.length).to eq 1000
      expect(expected.first.class).to eq Customer
    end

    it '#find_by_id returns the customer with matching id' do
      id = 100
      expected = @se.customers.find_by_id(id)

      expect(expected.id).to eq id
      expect(expected.class).to eq Customer
    end

    it '#find_all_by_first_name returns all customers with matching first name' do
      fragment = 'oe'
      expected = @se.customers.find_all_by_first_name(fragment)

      expect(expected.length).to eq 8
      expect(expected.first.class).to eq Customer
    end

    it '#find_all_by_last_name returns all customers with matching last name' do
      fragment = 'On'
      expected = @se.customers.find_all_by_last_name(fragment)

      expect(expected.length).to eq 85
      expect(expected.first.class).to eq Customer
    end

    it '#find_all_by_first_name and #find_all_by_last_name are case insensitive' do
      fragment = 'NN'
      expected = @se.customers.find_all_by_first_name(fragment)

      expect(expected.length).to eq 57
      expect(expected.first.class).to eq Customer

      fragment = 'oN'
      expected = @se.customers.find_all_by_last_name(fragment)

      expect(expected.length).to eq 85
      expect(expected.first.class).to eq Customer
    end

    it '#create creates a new customer instance' do
      attributes = {
        first_name: 'Joan',
        last_name: 'Clarke',
        created_at: Time.now,
        updated_at: Time.now
      }
      @se.customers.create(attributes)
      expected = @se.customers.find_by_id(1001)
      expect(expected.first_name).to eq 'Joan'
    end

    it '#update updates a customer' do
      attributes = {
        first_name: 'Joan',
        last_name: 'Clarke',
        created_at: Time.now,
        updated_at: Time.now
      }
      @se.customers.create(attributes)

      original_time = @se.customers.find_by_id(1001).updated_at
      attributes = {
        last_name: 'Smith'
      }
      @se.customers.update(1001, attributes)
      expected = @se.customers.find_by_id(1001)
      expect(expected.last_name).to eq 'Smith'
      expect(expected.first_name).to eq 'Joan'
      expect(expected.updated_at).to be > original_time
    end

    it '#update cannot update id or created_at' do
      attributes = {
        first_name: 'Joan',
        last_name: 'Clarke',
        created_at: Time.now,
        updated_at: Time.now
      }
      @se.customers.create(attributes)

      attributes = {
        id: 2000,
        created_at: Time.now
      }
      @se.customers.update(1001, attributes)
      expected = @se.customers.find_by_id(2000)
      expect(expected).to eq nil
      expected = @se.customers.find_by_id(1001)
      expect(expected.created_at).not_to eq attributes[:created_at]
    end

    it '#update on unknown customer does nothing' do
      @se.customers.update(2000, {})
    end

    it '#delete deletes the specified customer' do
      attributes = {
        first_name: 'Joan',
        last_name: 'Clarke',
        created_at: Time.now,
        updated_at: Time.now
      }
      @se.customers.create(attributes)

      @se.customers.delete(1001)
      expected = @se.customers.find_by_id(1001)
      expect(expected).to eq nil
    end
  end
end
