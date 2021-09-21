require 'csv'
require 'simplecov'
require './lib/sales_engine'
require './lib/invoice_item_repo'
require './lib/invoice_item'
SimpleCov.start

RSpec.describe do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                     items: './data/items.csv',
                                     merchants: './data/merchants.csv',
                                     invoices: "./data/invoices.csv",
                                     invoice_items: './data/invoice_items.csv',
                                     customers: './data/customers.csv',
                                     transactions: './data/transactions.csv'
                                   })
  end

  it 'exists' do
    expect(@engine.invoice_items).to be_an_instance_of(InvoiceItemRepository)
  end

  it 'returns all known InvoiceItem instances' do
    expect(@engine.invoice_items.all.count).to eq(21830)
  end

  it 'can find invoiceitem by id' do
    results = @engine.invoice_items.find_by_id(1)

    expect(results.item_id).to eq(263519844)
  end

  it 'can find all by an item_id' do
    results = @engine.invoice_items.find_all_by_item_id(263519844)
    expect(results.count).to eq(164)
  end

  it 'can find items by invoice id' do
    results = @engine.invoice_items.find_all_by_invoice_id(2)
    expect(results.count).to eq(4)
  end

  it 'can create a new invoice id' do
    attributes = {
      :item_id => 8,
      :invoice_id => 7,
      :quantity => 10,
      :unit_price => 10,
      :created_at => Time.now,
      :updated_at  => Time.now,
                  }
    @engine.invoice_items.create(attributes)
    results = @engine.invoice_items.find_by_id(21831)
    expect(results.item_id).to eq(8)
  end

  it 'can update the invoice_items status' do
    attributes = {
      :quantity => 7,
      :unit_price => 1
                  }
    @engine.invoice_items.update(1,attributes)
    expected = @engine.invoice_items.find_by_id(1)
    expect(expected.quantity).to eq(7)
    expect(expected.unit_price).to eq(1)
  end

  it 'can delete a invoice by id' do
    @engine.invoice_items.delete(6969)
    expect(@engine.invoice_items.all.count).to eq(21829)
  end




end
