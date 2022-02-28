# Invoice Test spec
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require 'pry'
require 'bigdecimal'

RSpec.describe 'Iteration 2' do
  context 'Invoices' do
    before(:each) do
      @se = SalesEngine.from_csv({
                                   items: './data/items.csv',
                                   merchants: './data/merchants.csv',
                                   invoices: './data/invoices.csv'
                                 })
      @sa = @se.analyst
    end

    it '#all returns all invoices' do
      expected = @se.invoices.all

      expect(expected.length).to eq 4985
    end

    it '#find_by_id returns an invoice associated to the given id' do
      invoice_id = 3452
      expected = @se.invoices.find_by_id(invoice_id)

      expect(expected.id).to eq invoice_id
      expect(expected.merchant_id).to eq 12_335_690
      expect(expected.customer_id).to eq 679
      expect(expected.status).to eq :pending

      invoice_id = 5000
      expected = @se.invoices.find_by_id(invoice_id)

      expect(expected).to eq nil
    end

    it '#find_all_by_customer_id returns all invoices associated with given customer' do
      customer_id = 300
      expected = @se.invoices.find_all_by_customer_id(customer_id)

      expect(expected.length).to eq 10

      customer_id = 1000
      expected = @se.invoices.find_all_by_customer_id(customer_id)

      expect(expected).to eq []
    end

    it '#find_all_by_merchant_id returns all invoices associated with given merchant' do
      merchant_id = 12_335_080
      expected = @se.invoices.find_all_by_merchant_id(merchant_id)

      expect(expected.length).to eq 7

      merchant_id = 1000
      expected = @se.invoices.find_all_by_merchant_id(merchant_id)

      expect(expected).to eq []
    end

    it '#find_all_by_status returns all invoices associated with given status' do
      status = :shipped
      expected = @se.invoices.find_all_by_status(status)

      expect(expected.length).to eq 2839

      status = :pending
      expected = @se.invoices.find_all_by_status(status)

      expect(expected.length).to eq 1473

      status = :sold
      expected = @se.invoices.find_all_by_status(status)

      expect(expected).to eq []
    end

    it '#create creates a new invoice instance' do
      attributes = {
        customer_id: 7,
        merchant_id: 8,
        status: 'pending',
        created_at: Time.now,
        updated_at: Time.now
      }
      @se.invoices.create(attributes)
      expected = @se.invoices.find_by_id(4986)
      expect(expected.merchant_id).to eq 8
    end

    it '#update updates an invoice' do
      attributes = {
        customer_id: 7,
        merchant_id: 8,
        status: 'pending',
        created_at: Time.now,
        updated_at: Time.now
      }
      @se.invoices.create(attributes)

      original_time = @se.invoices.find_by_id(4986).updated_at
      attributes = {
        status: :success
      }
      @se.invoices.update(4986, attributes)
      expected = @se.invoices.find_by_id(4986)
      expect(expected.status).to eq :success
      expect(expected.customer_id).to eq 7
      expect(expected.updated_at).to be > original_time
    end
  end
end
