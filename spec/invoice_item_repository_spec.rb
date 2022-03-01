require 'pry'
require 'rspec'
require 'csv'
require 'date'
require 'bigdecimal/util'
require './lib/invoice_item_repository'
require './lib/sales_engine'

RSpec.describe InvoiceItemRepository do

  before(:each) do
    @se = SalesEngine.from_csv({
            :items     => "./data/items.csv",
            :merchants => "./data/merchants.csv",
            :invoices => './data/invoices.csv',
            :invoice_items => "./data/invoice_items.csv"
                              })
  end


  it 'exists' do
    expect(@se.invoice_items).to be_a(InvoiceItemRepository)
  end

  it 'has retreivable attributes' do
    expect(@se.invoice_items.all).to be_a(Array)
    expect(@se.invoice_items.all[1]).to be_a(InvoiceItem)
  end

  it 'can find by the item id' do
    id = 10
    expected = @se.invoice_items.find_by_id(id)
    expect(expected.id).to eq id
    expect(expected.item_id).to eq 263523644
    expect(expected.invoice_id).to eq 2
  end

  it 'can find all item invoices by the item id' do
    item_id = 263408101
    expected = @se.invoice_items.find_all_by_item_id(item_id)
    expect(expected.first.item_id).to eq 263408101
    expect(expected.length).to eq 11
    expect(expected.first).to be_a(InvoiceItem)
  end

  it 'can find all item invoices by the invoice id' do
    invoice_id = 100
    expected = @se.invoice_items.find_all_by_invoice_id(invoice_id)
    expect(expected.first.invoice_id).to eq 100
    expect(expected.length).to eq 3
    expect(expected.first).to be_a(InvoiceItem)
  end

  it 'creates a new invoice item' do
    attributes = {
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      }
      @se.invoice_items.create(attributes)
      expected = @se.invoice_items.find_by_id(21831)
      expect(expected.item_id).to eq 7
  end

  it 'updates an existing invoice item in the repository' do
    attributes = {
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      }
      @se.invoice_items.create(attributes)
    original_time = @se.invoice_items.find_by_id(21831).updated_at
      attributes = {
        quantity: 13
      }
      @se.invoice_items.update(21831, attributes)
      expected = @se.invoice_items.find_by_id(21831)
      expect(expected.quantity).to eq 13
      expect(expected.item_id).to eq 7
      expect(expected.updated_at).to be > original_time
  end

  it 'can delete an invoice item instance by the id number' do
    attributes = {
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @se.invoice_items.create(attributes)
    @se.invoice_items.delete(21831)
      expected = @se.invoice_items.find_by_id(21831)
      expect(expected).to eq nil
  end

end
