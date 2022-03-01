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
  end
end
