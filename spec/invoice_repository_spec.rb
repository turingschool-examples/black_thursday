require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require_relative 'spec_helper'
require 'pry'

  RSpec.describe InvoiceRepository do

    before (:each) do
      # binding.pry
      se = SalesEngine.from_csv({:items=> "./data/items.csv", :merchants => "./data/merchants.csv", :invoices=> "./data/invoices.csv"})
      @invoices = se.invoices
    end

    it 'exists' do
      expect(@invoices).to be_a(InvoiceRepository)
    end

    it '#find_by_id finds id by invoice id' do
      expect(@invoices.find_by_id(1).merchant_id).to eq(12335938)
    end

    it '#find_all_by_customer_id' do
      expect(@invoices.find_all_by_customer_id(1).length).to eq(8)
    end

    xit '#find_all_by_merchant_id' do
      expect(@invoices.find_all_by_merchant_id(12335938).length).to eq(16)
    end

  end
