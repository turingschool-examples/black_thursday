require 'rspec'
require 'bigdecimal'
require 'time'
require './lib/invoices'
require './lib/sales_engine'
require './lib/invoices_repo'

RSpec.describe Invoice do

  se = SalesEngine.from_csv({
  :invoices => "./data/invoices.csv",
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"
  })
  invoice_repo = se.invoices

  context 'it exists' do
    it 'exists' do
      expect(invoice_repo.invoice_list[0]).to be_instance_of(Invoice)
    end
  end

  context 'attr_accessor' do
    it 'can return id' do
      expect(invoice_repo.invoice_list[0].id).to eq(1)
    end

    it 'can return customer id' do
      expect(invoice_repo.invoice_list[0].customer_id).to eq(1)
    end

    it 'can return merchant id' do
      expect(invoice_repo.invoice_list[0].merchant_id).to eq(12335938)
    end

    it 'can return status' do
      expect(invoice_repo.invoice_list[0].status).to eq("pending")
    end

    it 'can return time created at' do
      expect(invoice_repo.invoice_list[0].created_at).to eq(Time.parse("2009-02-07 00:00:00 -0700"))
    end

    it 'can return time updated at' do
      expect(invoice_repo.invoice_list[0].updated_at).to eq(Time.parse("2014-03-15 00:00:00 -0600"))
    end
  end
end
