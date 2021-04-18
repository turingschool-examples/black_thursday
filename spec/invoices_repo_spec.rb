require 'rspec'
require 'bigdecimal'
require 'time'
require './lib/sales_engine'
require './lib/items'
require './lib/items_repo'
require './lib/merchants'
require './lib/merchants_repo'
require './lib/invoices'
require './lib/invoices_repo'

RSpec.describe InvoiceRepo do

  se = SalesEngine.from_csv({
  :invoices => "./data/invoices.csv",
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"
  })
  invoice_repository = se.invoices

  context 'it exists' do
    it 'exists' do
      expect(invoice_repository).to be_instance_of(InvoiceRepo)
    end
  end

  context 'methods' do
    it 'can return all invoices' do
      expect(invoice_repository.all.class).to eq(Array)
      expect(invoice_repository.all.length).to eq(4985)
    end

    it "can find invoice by id" do
      expect(invoice_repository.find_by_id(1)).to be_instance_of(Invoice)
      expect(invoice_repository.find_by_id(10000)).to eq(nil)
      expect(invoice_repository.find_by_id(1)).to eq(invoice_repository.invoice_list[0])
    end

    it 'can find all by customer id' do
      expect(invoice_repository.find_all_by_customer_id(1).class).to eq(Array)
      expect(invoice_repository.find_all_by_customer_id(1).length).to eq(8)
      expect(invoice_repository.find_all_by_customer_id(1).first).to eq(invoice_repository.invoice_list[0])
    end

    it 'can find all by merchant id' do
      expect(invoice_repository.find_all_by_merchant_id(12335938).class).to eq(Array)
      expect(invoice_repository.find_all_by_merchant_id(12335938).length).to eq(16)
      expect(invoice_repository.find_all_by_merchant_id(12335938).first).to eq(invoice_repository.invoice_list[0])
    end
  end
end
