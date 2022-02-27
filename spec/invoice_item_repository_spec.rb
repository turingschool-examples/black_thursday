require 'pry'
require 'rspec'
require 'csv'
require 'date'
require 'bigdecimal/util'
require_relative 'invoice_item'
require_relative 'sales_module'

RSpec.describe InvoiceItemRepository do

  before(:each) do
    @se = SalesEngine.from_csv({
            :items     => "./data/items.csv",
            :merchants => "./data/merchants.csv",
            :invoices => './data/invoices.csv',
            :invoice_items => "./data/invoice_items.csv"
                              })
  end

  describe 'instantiation' do
    it 'exists' do
      expect(@se.invoice_items).to be_a(InvoiceItemRepository)
    end





  end






end
