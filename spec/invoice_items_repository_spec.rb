#Invoice Items Test spec
require_relative '../lib/invoice_items_repository'
require_relative '../lib/invoice_items'
require_relative '../lib/sales_engine'
require 'pry'
require 'bigdecimal'

RSpec.describe 'Iteration 3' do
  context 'Invoice Items Repository' do
    before(:each) do
      @se = SalesEngine.from_csv({
                                   items: './data/items.csv',
                                   merchants: './data/merchants.csv',
                                   invoices: './data/invoices.csv',
                                   invoice_items: './data/invoice_items.csv'
                                 })
      @sa = @se.analyst
    end

    it "#all returns an array of all invoice item instances" do
      expected = @se.invoice_items.all
      expect(expected.count).to eq 21830
    end

    it "#find_by_id finds an invoice_item by id" do
      id = 10
      expected = @se.invoice_items.find_by_id(id)

      expect(expected.id).to eq id
      expect(expected.item_id).to eq 263523644
      expect(expected.invoice_id).to eq 2
    end

    it "#find_by_id returns nil if the invoice item does not exist" do
      id = 200000
      expected = @se.invoice_items.find_by_id(id)

      expect(expected).to eq nil
    end

    it "#find_all_by_item_id finds all items matching given item_id" do
      item_id = 263408101
      expected = @se.invoice_items.find_all_by_item_id(item_id)

      expect(expected.length).to eq 11
      expect(expected.first.class).to eq InvoiceItem
    end

    it "#find_all_by_item_id returns an empty array if there are no matches" do
      item_id = 10
      expected = @se.invoice_items.find_all_by_item_id(item_id)

      expect(expected.length).to eq 0
      expect(expected.empty?).to eq true
    end




  end
end
