require 'CSV'
require 'sales_engine'
require 'invoice_item_repo'
require 'bigdecimal'

RSpec.describe InvoiceItemRepo do
  before(:each) do
    @sales_engine = SalesEngine.from_csv({:items => './data/items.csv',
                                          :merchants => './data/merchants.csv',
                                          :invoices => './data/invoices.csv',
                                          :invoice_items => './data/invoice_items.csv',
                                          :transactions  => './data/transactions.csv',
                                          :customers => './data/customers.csv'
                                        })
  end

   describe '#instantiation' do
    xit '::new' do
      invoice_item_repo = sales_engine.invoice_items

      expect(invoice_item_repo).to be_an_instance_of(InvoiceItemRepository)
    end

    xit 'has attributes' do
      invoice_item_repo = sales_engine.invoice_items

      expect(invoice_item_repo.invoice_items).to eq([])
    end
  end

  describe '#methods' do
    xit '#all' do
      invoice_item_repo = sales_engine.invoice_items

      expect(invoice_item_repo.all).to be_an_instance_of(Array)
    end

    it 'can find an invoice item by id' do
      invoice_item_repo = @sales_engine.invoice_items
      collection = invoice_item_repo.invoice_items
      invoice_item = invoice_item_repo.create({
                                                :id => 6,
                                                :item_id => 7,
                                                :invoice_id => 8,
                                                :quantity => 1,
                                                # :unit_price => BigDecimal.new(10.99, 4),
                                                :created_at => Time.now,
                                                :updated_at => Time.now
                                              })

      expect(invoice_item_repo.find_by_id(invoice_item.id, collection)).to eq(invoice_item)
      expect(invoice_item_repo.find_by_id(999999999, collection)).to eq(nil)
    end

    xit '#find all but item id ' do
      invoice_item_repo = @sales_engine.invoice_items
      collection = invoice_item_repo.invoice_items
      invoice_item = invoice_item_repo.create({
                                                :id => 6,
                                                :item_id => 7,
                                                :invoice_id => 8,
                                                :quantity => 1,
                                                :unit_price => 0.0,
                                                :created_at => Time.now,
                                                :updated_at => Time.now
                                              })

      # expect(invoice_item_repo.find_all_by_item_id(invoice_item.item_id, collection)).to eq(invoice_item)
      expect(invoice_item_repo.find_all_by_item_id(999999999, collection)).to eq([])
    end

    it '#find all by invoice id' do
      invoice_item_repo = @sales_engine.invoice_items
      collection = invoice_item_repo.invoice_items
      invoice_item = invoice_item_repo.create({
                                                :id => 6,
                                                :item_id => 7,
                                                :invoice_id => 8,
                                                :quantity => 1,
                                                # :unit_price => BigDecimal.new(10.99, 4),
                                                :created_at => Time.now,
                                                :updated_at => Time.now
                                              })


      expect(invoice_item_repo.find_all_by_invoice_id(invoice_item.id)).to eq([invoice_id])
      expect(InvoiceRepo.find_all_by_invoice_id(0)).to eq([])
    end
  end
end
