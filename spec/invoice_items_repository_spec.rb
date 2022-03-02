# Invoice Items Test spec
require_relative '../lib/invoice_items_repository'
require_relative '../lib/sales_engine'
require 'pry'
require 'bigdecimal'

RSpec.describe 'Iteration 3' do
  context 'Invoice Items Repository' do
    before(:each) do
      @se = SalesEngine.from_csv({ invoice_items: './data/invoice_items.csv' })
    end

    it '#all returns an array of all invoice item instances' do
      expected = @se.invoice_items.all
      expect(expected.count).to eq 21_830
    end

    it '#find_by_id finds an invoice_item by id' do
      id = 10
      expected = @se.invoice_items.find_by_id(id)

      expect(expected.id).to eq id
      expect(expected.item_id).to eq 263_523_644
      expect(expected.invoice_id).to eq 2
    end

    it '#find_by_id returns nil if the invoice item does not exist' do
      id = 200_000
      expected = @se.invoice_items.find_by_id(id)

      expect(expected).to eq nil
    end

    it '#find_all_by_item_id finds all items matching given item_id' do
      item_id = 263_408_101
      expected = @se.invoice_items.find_all_by_item_id(item_id)

      expect(expected.length).to eq 11
      expect(expected.first.class).to eq InvoiceItem
    end

    it '#find_all_by_item_id returns an empty array if there are no matches' do
      item_id = 10
      expected = @se.invoice_items.find_all_by_item_id(item_id)

      expect(expected.length).to eq 0
      expect(expected.empty?).to eq true
    end

    it '#find_all_by_invoice_id finds all items matching given item_id' do
      invoice_id = 100
      expected = @se.invoice_items.find_all_by_invoice_id(invoice_id)

      expect(expected.length).to eq 3
      expect(expected.first.class).to eq InvoiceItem
    end

    it '#find_all_by_invoice_id returns an empty array if there are no matches' do
      invoice_id = 1_234_567_890
      expected = @se.invoice_items.find_all_by_invoice_id(invoice_id)

      expect(expected.length).to eq 0
      expect(expected.empty?).to eq true
    end

    it '#create creates a new invoice item instance' do
      attributes = {
        item_id: 7,
        invoice_id: 8,
        quantity: 1,
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.now
      }
      @se.invoice_items.create(attributes)
      expected = @se.invoice_items.find_by_id(21_831)
      expect(expected.item_id).to eq 7
    end

    it '#update updates an invoice item' do
      attributes = {
        item_id: 7,
        invoice_id: 8,
        quantity: 1,
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.now
      }

      @se.invoice_items.create(attributes)
      original_time = @se.invoice_items.find_by_id(21_831).updated_at
      attributes = {
        quantity: 13
      }
      @se.invoice_items.update(21_831, attributes)
      expected = @se.invoice_items.find_by_id(21_831)
      expect(expected.quantity).to eq 13
      expect(expected.item_id).to eq 7
      expect(expected.updated_at).to be > original_time
    end

    it '#update cannot update id, item_id, invoice_id, or created_at' do
      attributes = {
        item_id: 7,
        invoice_id: 8,
        quantity: 1,
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.now
      }
      @se.invoice_items.create(attributes)

      attributes = {
        id: 22_000,
        item_id: 32,
        invoice_id: 53,
        created_at: Time.now
      }
      @se.invoice_items.update(21_831, attributes)
      expected = @se.invoice_items.find_by_id(22_000)
      expect(expected).to eq nil
      expected = @se.invoice_items.find_by_id(21_831)
      expect(expected.item_id).not_to eq attributes[:item_id]
      expect(expected.invoice_id).not_to eq attributes[:invoice_id]
      expect(expected.created_at).not_to eq attributes[:created_at]
    end

    it '#update on unknown invoice item does nothing' do
      @se.invoice_items.update(22_000, {})
    end

    it '#delete deletes the specified invoice' do
      attributes = {
        item_id: 7,
        invoice_id: 8,
        quantity: 1,
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.now
      }
      @se.invoice_items.create(attributes)
      expect(@se.invoice_items.find_by_id(21_831)).to be_a(InvoiceItem)
      @se.invoice_items.delete(21_831)
      expected = @se.invoice_items.find_by_id(21_831)
      expect(expected).to eq nil
    end

    it '#delete on unknown invoice does nothing' do
      @se.invoice_items.delete(22_000)
    end
  end
end
