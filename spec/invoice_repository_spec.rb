# Invoice Test spec
require_relative '../lib/invoice'
require 'pry'

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
  end
end
