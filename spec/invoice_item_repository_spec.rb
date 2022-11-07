require './lib/invoice_item'
require './lib/invoice_item_repository'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/item'
require './lib/sales_analyst'
require './lib/transaction'
require './lib/transaction_repository'

RSpec.describe InvoiceItemRepository do
  let!(:invoice_item_repository){InvoiceItemRepository.new('./data/invoice_items.csv', nil)}

  it 'is an invoice item repository class' do
    # require 'pry'; binding.pry
    expect(invoice_item_repository).to be_a(InvoiceItemRepository)
  end

  it "#all returns an array of all invoice item instances" do
      # expected = invoice_item_repository.invoice_items.all
      expect(invoice_item_repository.invoice_items.count).to eq 21830
    end

  it "#find_by_id finds an invoice_item by id" do
    id = 10
    expected = engine.invoice_items.find_by_id(id)

    expect(expected.id).to eq id
    expect(expected.item_id).to eq 263523644
    expect(expected.invoice_id).to eq 2
  end

  it "#find_by_id returns nil if the invoice item does not exist" do
    id = 200000
    expected = engine.invoice_items.find_by_id(id)

    expect(expected).to eq nil
  end

  xit "#find_all_by_item_id finds all items matching given item_id" do
    item_id = 263408101
    expected = engine.invoice_items.find_all_by_item_id(item_id)

    expect(expected.length).to eq 11
    expect(expected.first.class).to eq InvoiceItem
  end

  xit "#find_all_by_item_id returns an empty array if there are no matches" do
    item_id = 10
    expected = engine.invoice_items.find_all_by_item_id(item_id)

    expect(expected.length).to eq 0
    expect(expected.empty?).to eq true
  end

  xit "#find_all_by_invoice_id finds all items matching given item_id" do
    invoice_id = 100
    expected = engine.invoice_items.find_all_by_invoice_id(invoice_id)

    expect(expected.length).to eq 3
    expect(expected.first.class).to eq InvoiceItem
  end

  xit "#find_all_by_invoice_id returns an empty array if there are no matches" do
    invoice_id = 1234567890
    expected = engine.invoice_items.find_all_by_invoice_id(invoice_id)

    expect(expected.length).to eq 0
    expect(expected.empty?).to eq true
  end

  xit "#create creates a new invoice item instance" do
    attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }
    engine.invoice_items.create(attributes)
    expected = engine.invoice_items.find_by_id(21831)
    expect(expected.item_id).to eq 7
  end

  xit "#update updates an invoice item" do
    original_time = engine.invoice_items.find_by_id(21831).updated_at
    attributes = {
      quantity: 13
    }
    engine.invoice_items.update(21831, attributes)
    expected = engine.invoice_items.find_by_id(21831)
    expect(expected.quantity).to eq 13
    expect(expected.item_id).to eq 7
    expect(expected.updated_at).to be > original_time
  end

  xit "#update cannot update id, item_id, invoice_id, or created_at" do
    attributes = {
      id: 22000,
      item_id: 32,
      invoice_id: 53,
      created_at: Time.now
    }
    engine.invoice_items.update(21831, attributes)
    expected = engine.invoice_items.find_by_id(22000)
    expect(expected).to eq nil
    expected = engine.invoice_items.find_by_id(21831)
    expect(expected.item_id).not_to eq attributes[:item_id]
    expect(expected.invoice_id).not_to eq attributes[:invoice_id]
    expect(expected.created_at).not_to eq attributes[:created_at]
  end

  xit "#update on unknown invoice item does nothing" do
    engine.invoice_items.update(22000, {})
  end

  xit "#delete deletes the specified invoice" do
    engine.invoice_items.delete(21831)
    expected = engine.invoice_items.find_by_id(21831)
    expect(expected).to eq nil
  end

  xit "#delete on unknown invoice does nothing" do
    engine.invoice_items.delete(22000)
  end
end