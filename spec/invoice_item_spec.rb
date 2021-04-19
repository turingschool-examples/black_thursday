require 'rspec'
require 'bigdecimal'
require 'time'
require './lib/invoice_item'
require './lib/sales_engine'
require './lib/invoice_item_repo'

RSpec.describe InvoiceItem do

  se = SalesEngine.from_csv({
    :invoice_items => './data/invoice_items.csv'
    })
  invoice_item_repo = se.invoice_items

  context 'instantiation' do
    it 'exists' do
      expect(invoice_item_repo.invoice_item_list[0]).to be_instance_of(InvoiceItem)
    end

    it 'can return id' do
      expect(invoice_item_repo.invoice_item_list[0].id).to eq(1)
    end

    it 'can return item id' do
      expect(invoice_item_repo.invoice_item_list[0].item_id).to eq(263519844)
    end

    it 'can return invoice id' do
      expect(invoice_item_repo.invoice_item_list[0].invoice_id).to eq(1)
    end

    it 'can return quantity' do
      expect(invoice_item_repo.invoice_item_list[0].quantity).to eq(5)
    end

    it 'can return unit price' do
      expect(invoice_item_repo.invoice_item_list[0].unit_price).to eq(0.13635e3)
    end

    it 'can return created at' do
      expect(invoice_item_repo.invoice_item_list[0].created_at).to eq(Time.parse("2012-03-27 14:54:09 UTC"))
    end

    it 'can return updated at' do
      expect(invoice_item_repo.invoice_item_list[0].updated_at).to eq(Time.parse("2012-03-27 14:54:09 UTC"))
    end
  end
end
