require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'
require 'bigdecimal/util'

RSpec.describe InvoiceItemRepository do
  describe 'initialization' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./data/items.csv",
                                        :merchants => "./data/merchants.csv",
                                        # :invoices => "./data/invoices.csv",
                                        # :customers => "./data/customers.csv",
                                        :invoice_items => "./data/invoice_items.csv"
                                        # :transactions => "./data/transactions.csv"
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
                                                          :customers => "./data/customers.csv",
                                                          :transactions => "./data/transactions.csv"
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
                                                          :customers => "./data/customers.csv",
                                                          :transactions => "./data/transactions.csv"
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

    it 'find all by item id returns correct invoice id' do
      expect(invoice_item_repo.find_all_by_item_id(263408101).length).to eq(11)
      expect(invoice_item_repo.find_all_by_item_id(263408101).first.class).to eq(InvoiceItem)
    end

    it 'find all by item id will return an empty array if there are no matches' do
      expect(invoice_item_repo.find_all_by_item_id(10).length).to eq(0)
      expect(invoice_item_repo.find_all_by_item_id(10).empty?).to eq(true)
    end

    it 'find all by invoice id finds all items with matching id' do
      expect(invoice_item_repo.find_all_by_invoice_id(100).length).to eq(3)
      expect(invoice_item_repo.find_all_by_invoice_id(100).first.class).to eq(InvoiceItem)
    end

    it 'find all by invoice id returns an empty array if there are no matches' do
      expect(invoice_item_repo.find_all_by_invoice_id(253961).length).to eq(0)
      expect(invoice_item_repo.find_all_by_invoice_id(253961).empty?).to eq(true)
    end
  end



  describe 'create, update & delete method' do
    sales_engine = SalesEngine.from_csv({
                                                          :items     => "./data/items.csv",
                                                          :merchants => "./data/merchants.csv",
                                                          :invoices => "./data/invoices.csv",
                                                          :invoice_items => "./data/invoice_items.csv",
                                                          :customers => "./data/customers.csv",
                                                          :transactions => "./data/transactions.csv"
                                                          })
    invoice_item_repo = sales_engine.invoice_items


    it 'create can create a new instance with attributes' do
      attributes = {
                          :item_id => 7,
                          :invoice_id => 8,
                          :quantity => 1,
                          :unit_price => ("1099"),
                          :created_at => Time.now,
                          :updated_at => Time.now
                          }

      invoice_item_repo.create(attributes)
      expect(invoice_item_repo.find_by_id(21831).item_id).to eq(7)
    end

    it 'update can update an invoice item' do
      original_time = invoice_item_repo.find_by_id(21831).updated_at
      attributes = {
                          quantity: 13
                          }
      invoice_item_repo.update(21831, attributes)
      expect(invoice_item_repo.find_by_id(21831).quantity).to eq(13)
      expect(invoice_item_repo.find_by_id(21831).item_id).to eq(7)
      expect(invoice_item_repo.find_by_id(21831).updated_at).to be > original_time
    end

    it 'update does not update id, item id invoice id or created at' do
      attributes = {
                          id: 22000,
                          item_id: 32,
                          invoice_id: 53,
                          created_at: Time.now
                        }
      invoice_item_repo.update(21831, attributes)
      expect(invoice_item_repo.find_by_id(22000)).to eq(nil)
      expect(invoice_item_repo.find_by_id(21831).item_id).not_to eq(attributes[:item_id])
      expect(invoice_item_repo.find_by_id(21831).invoice_id).not_to eq(attributes[:invoice_id])
      expect(invoice_item_repo.find_by_id(21831).created_at).not_to eq(attributes[:created_at])
    end

    it 'update does not update an unknown item' do
      invoice_item_repo.update(22000, {})
    end

    it "delete deletes the specified invoice" do
      invoice_item_repo.delete(21831)
      expect(invoice_item_repo.find_by_id(21831)).to eq nil
    end

    it "delete on unknown invoice does nothing" do
      invoice_item_repo.delete(22000)
    end
  end
end
