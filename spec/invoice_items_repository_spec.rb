#Invoice Items Test spec
require_relative '../lib/invoice_items_repository'
require_relative '../lib/invoices_repository'
require_relative '../lib/sales_engine'
require 'pry'
require 'bigdecimal'

RSpec.describe 'Iteration 3' do
  context 'Invoice Items Repository' do
    before(:each) do
      @se = SalesEngine.from_csv({
                                   items: './data/items.csv',
                                   merchants: './data/merchants.csv',
                                   invoices: './data/invoices.csv', invoice_items: './data/invoice_items.csv'
                                 })
      @sa = @se.analyst
    end

    it "#all returns an array of all invoice item instances" do
      expected = engine.invoice_items.all
      expect(expected.count).to eq 21830
    end

    
