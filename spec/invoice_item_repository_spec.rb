require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'
# require_relative '../lib/invoice_item'
# require_relative '../lib/invoice_repository'
require 'bigdecimal/util'

RSpec.describe InvoiceItemRepository do
  describe 'initialization' do
    sales_engine = SalesEngine.from_csv({
                                                          :items     => "./data/items.csv",
                                                          :merchants => "./data/merchants.csv",
                                                          :invoices => "./data/invoices.csv",
                                                          :invoice_items => "./data/invoice_items.csv",
                                                          :customers => "./data/customers.csv"
                                                          })
    invoice_item_repo = sales_engine.invoice_items

    it 'exists' do
      expect(invoice_item_repo).to be_instance_of(InvoiceItemRepository)
    end

    it 'can create invoice item objects' do
      expect(invoice_item_repo.array_of_objects[0]).to be_instance_of(InvoiceItem)
    end
  end

  describe 'all method' do
    sales_engine = SalesEngine.from_csv({
                                                          :items     => "./data/items.csv",
                                                          :merchants => "./data/merchants.csv",
                                                          :invoices => "./data/invoices.csv",
                                                          :invoice_items => "./data/invoice_items.csv",
                                                          :customers => "./data/customers.csv"
                                                          })
    invoice_item_repo = sales_engine.invoice_items

    it 'returns array of all invoice items' do
      expect(invoice_item_repo.all.count).to eq(21830)
    end
  end

  describe 'various find methods' do
    sales_engine = SalesEngine.from_csv({
                                                          :items     => "./data/items.csv",
                                                          :merchants => "./data/merchants.csv",
                                                          :invoices => "./data/invoices.csv",
                                                          :invoice_items => "./data/invoice_items.csv",
                                                          :customers => "./data/customers.csv"
                                                          })
    invoice_item_repo = sales_engine.invoice_items

#REPEATED IN REPOSITORY TESTS
    it 'find by id returns an instance by matching id' do
      expect(invoice_item_repo.find_by_id(10).id).to eq(10)
      expect(invoice_item_repo.find_by_id(10).item_id).to eq(263523644)
      expect(invoice_item_repo.find_by_id(10).invoice_id).to eq(2)
    end

#REPEATED IN REPOSITORY TESTS
    it 'find by id returns a nil if no id match' do
      expect(invoice_item_repo.find_by_id(200000)).to eq(nil)
    end

    it 'find all by item id' do
      expect(invoice_item_repo.find_all_by_item_id(263408101).length).to eq(11)
    end

  end

  describe 'delete method' do
    sales_engine = SalesEngine.from_csv({
                                                          :items     => "./data/items.csv",
                                                          :merchants => "./data/merchants.csv",
                                                          :invoices => "./data/invoices.csv",
                                                          :invoice_items => "./data/invoice_items.csv",
                                                          :customers => "./data/customers.csv"
                                                          })
    invoice_item_repo = sales_engine.invoice_items

    it "delete deletes the specified invoice" do
      invoice_item_repo.delete(21831)

      expected = invoice_item_repo.find_by_id(21831)
      expect(expected).to eq nil
    end

    it "delete on unknown invoice does nothing" do
      invoice_item_repo.delete(22000)
    end
  end
end
