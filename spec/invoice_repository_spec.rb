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

    it '#find_all_by_merchant_id' do
      expect(@invoices.find_all_by_merchant_id(12335938).length).to eq(16)
    end

    it ' #find_all_by_status' do
      expect(@invoices.find_all_by_status(:pending).length).to eq(1473)
    end

    it 'creates a new invoice instance' do
      attributes = { customer_id: 999,
                    merchant_id: 12335541,
                    status: :shipped,
                    created_at: Time.now,
                    updated_at: Time.now
                  }


                  expect(@invoices.create(attributes)).to eq(Invoice.new({
                    customer_id: 999,
                    merchant_id: 12335541,
                    status: :shipped,
                    created_at: Time.now,
                    updated_at: Time.now,
                    id: 4986
                  }))
    end

    it 'updates an existing invoice instance such as status, customer_id, and updated_at, and nothing else' do

      original_time = @invoices.find_by_id(1).updated_at
      attribute = { customer_id: 999,
                    merchant_id: 12335541,
                    status: :shipped,
                    created_at: Time.now,
                    updated_at: Time.now
                  }
      expected = @invoices.update(1, attribute)
      expect(expected.customer_id).to eq(1)
      expect(expected.merchant_id).to eq(12335938)
      expect(expected.status).to eq(:shipped)
      expect(expected.created_at).to eq(Time.parse("2009-02-07"))
      expect(expected.updated_at).to be > original_time
    end

    it "deletes a invoice by id" do
      @invoices.delete(1)
      expected = @invoices.find_by_id(1)
      expect(expected).to eq nil
    end

end
