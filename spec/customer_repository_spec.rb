require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

RSpec.describe 'Iteration 3' do
  context 'CustomerRepository' do
    before(:each) do
      @se = SalesEngine.from_csv({
                                   items: './data/items.csv',
                                   merchants: './data/merchants.csv',
                                   invoices: './data/invoices.csv',
                                   customers: './data/customers.csv'
                                 })
    end

    it "all returns all customers" do
      expected = @se.customers.all
      expect(expected.length).to eq 1000
      expect(expected.first.class).to eq Customer
    end

    it "#find_by_id returns the customer with matching id" do
      id = 100
      expected = @se.customers.find_by_id(id)

      expect(expected.id).to eq id
      expect(expected.class).to eq Customer
    end

    it "#find_all_by_first_name returns all customers with matching first name" do
      fragment = "oe"
      expected = @se.customers.find_all_by_first_name(fragment)

      expect(expected.length).to eq 8
      expect(expected.first.class).to eq Customer
    end

    it "#find_all_by_last_name returns all customers with matching last name" do
      fragment = "On"
      expected = @se.customers.find_all_by_last_name(fragment)

      expect(expected.length).to eq 85
      expect(expected.first.class).to eq Customer
    end

    it "#find_all_by_first_name and #find_all_by_last_name are case insensitive" do
      fragment = "NN"
      expected = @se.customers.find_all_by_first_name(fragment)

      expect(expected.length).to eq 57
      expect(expected.first.class).to eq Customer

      fragment = "oN"
      expected = @se.customers.find_all_by_last_name(fragment)

      expect(expected.length).to eq 85
      expect(expected.first.class).to eq Customer
    end
  end
end
