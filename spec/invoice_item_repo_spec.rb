require 'rspec'
require 'bigdecimal'
require 'time'
require './lib/sales_engine'
require './lib/invoice_item'
require './lib/invoices_repo'

RSpec.describe InvoiceItemRepo do
  se = SalesEngine.from_csv({
    :invoice_items => "./data/invoice_items.csv"
    })
  invoice_item_repo = se.invoice_items

  context 'instantiation' do
    it 'exists' do
      expect(invoice_item_repo).to be_instance_of(InvoiceItemRepo)
    end
  end

  context 'methods' do
    it 'has attributes' do
      expect(invoice_item_repo.invoice_item_list[0]).to be_instance_of(InvoiceItem)
      expect(invoice_item_repo.invoice_item_list.length).to eq(21830)
    end

    it 'can return all invoice items' do
      expect(invoice_item_repo.all.length).to eq(21830)
    end

    it 'can find invoice items by id' do
      expect(invoice_item_repo.find_by_id(126)).to eq(invoice_item_repo.all[125])
    end

    it 'can find all invoice items by item id' do
      expect(invoice_item_repo.find_all_by_item_id(263519844).length).to eq(164)
    end
  end
end
