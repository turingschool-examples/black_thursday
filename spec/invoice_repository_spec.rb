require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require 'bigdecimal/util'

RSpec.describe InvoiceRepository do
  describe 'initialization' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv"
                              })
    invoice_repo = sales_engine.invoices

    it 'exists' do
      expect(invoice_repo).to be_instance_of(InvoiceRepository)
    end

    it 'can create invoice objects' do
      expect(invoice_repo.array_of_objects[0]).to be_instance_of(Invoice)
    end
  end

  describe 'all method' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv"
                              })
    invoice_repo = sales_engine.invoices

    it 'returns array of all invoices' do
      expect(invoice_repo.all.length).to eq(4985)
    end
  end

  describe 'various find methods' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv"
                              })
    invoice_repo = sales_engine.invoices

    it 'find_by_id returns an instance by matching id' do
      id = 3452

      expect(invoice_repo.find_by_id(id).id).to eq(id)
      expect(invoice_repo.find_by_id(id).status).to eq(:pending)
    end
  end

end
