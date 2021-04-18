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
      expect(invoice_repository.find_all_by_customer_id(9999999)).to eq([])
    end

    it 'can find all by merchant id' do
      expect(invoice_repository.find_all_by_merchant_id(12335938).class).to eq(Array)
      expect(invoice_repository.find_all_by_merchant_id(12335938).length).to eq(16)
      expect(invoice_repository.find_all_by_merchant_id(12335938).first).to eq(invoice_repository.invoice_list[0])
      expect(invoice_repository.find_all_by_merchant_id(999999999)).to eq([])
    end

    it 'can return invoices with matching status' do
      expect(invoice_repository.find_all_by_status("pending").class).to eq(Array)
      expect(invoice_repository.find_all_by_status("pending").length).to eq(1473)
      expect(invoice_repository.find_all_by_status("pending").first).to eq(invoice_repository.invoice_list[0])
      expect(invoice_repository.find_all_by_status("BlahBlah")).to eq([])
    end

    it 'can create new invoices' do
      attributes = {
        id: 4986,
        customer_id: 999,
        merchant_id: 12335541,
        status: "pending",
        created_at: Time.now,
        updated_at: Time.now
      }

      invoice_repository.create(attributes)
      expected = invoice_repository.find_by_id(4986)
      expect(expected.customer_id).to eq(999)
      expect(expected.merchant_id).to eq(12335541)
      expect(expected.status).to eq("pending")
    end

    it 'can update an invoice' do
      se_update = SalesEngine.from_csv({
      :invoices => "./data/invoices.csv",
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
      invoice_repository_update = se_update.invoices

      original_time = invoice_repository_update.find_by_id(1).updated_at
      attributes = {
        status: "shipped",
        updated_at: Time.now
      }
      expected = invoice_repository_update.update(1, attributes)

      expect(expected.status).to eq("shipped")
      expect(expected.updated_at).to be > original_time
    end

    it 'can delete an invoice' do
      se_delete = SalesEngine.from_csv({
      :invoices => "./data/invoices.csv",
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
      invoice_repository_delete = se_delete.invoices
      invoice_repository_delete.delete(1)

      expect(invoice_repository_delete.find_by_id(1)).to eq(nil)
    end
  end
end
