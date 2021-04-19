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
    xit '#all returns an array of all invoice item instances' do
      invoice_item_repo = sales_engine.invoice_items

      expect(invoice_item_repo.all).to be_an_instance_of(Array)
    end

    xit '#find_by_id finds an invoice_item by id' do
      expect(invoice_item_repo.id).to_eq(id)
      expect(invoice_item_repo.item_id).to eq 263523644
      expect(invoice_item_repo.invoice_id).to eq 2
    end

    xit 'find_all_by_item_id finds all items matching given item_id' do

      expect(invoice_item_repo.length).to eq 11
    end
  end
end
