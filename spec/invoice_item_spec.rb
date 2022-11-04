require './lib/invoice_item'
require './lib/invoice_item_repository'

RSpec.describe InvoiceItem do
  let!(:invoice_item) {InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
  }, nil)}

  it 'is a invoice item class' do
    require 'pry'; binding.pry
    expect(invoice_item).to be_(InvoiceItem)
  end

  it 'can return an integer id' do
    expect(invoice_item.id()).to eq() 
  end

  it 'can return nil if it is not within' do
    expect(invoice_item.id()).to eq(nil)
    expect(invoice_item.id()).to eq(nil)
  end

  it 'returns the item id' do
    expect(invoice_item.item_id()).to eq()
  end

  it 'can return mil if it is not within' do
    expect(invoice_item.item_id()).to eq(nil)
    expect(invoice_item.item_id()).to eq(nil)
  end

  it 'return the invoice id' do
    expect(invoice_item.invoice_id()).to eq()
  end

  it 'can return nil if it is not within' do
    expect(invoice_item.invoice_id()).to eq(nil)
    expect(invoice_item.invoice_id()).to eq(nil)
  end

  it 'returns the quanity' do
    expect(invoice_item.quanity()).to eq()
  end

  it 'can return nil if it is not within' do
    expect(invoice_item.quanity()).to eq(nil)
    expect(invoice_item.quanity()).to eq(nil)
  end

  it 'returns the unit price' do
    expect(invoice_item.unit_price).to eq()
  end

  it 'can return nil if it is not within' do
    expect(invoice_item.unit_price).to eq(nil)
    expect(invoice_item.unit_price).to eq(nil)
  end

  it 'returns the time instance for the date and time it ws first created' do
    expect(invoice_item.created_at).to eq()
  end

  it 'can return nil if it is not within' do
    expect(invoice_item.created_at).to eq(nil)
    expect(invoice_item.created_at).to eq(nil)
  end

  it 'returns a time instance for the date in invoice item was last modified' do
    expect(invoice_item.updated_at).to eq()
  end

  it 'can return nil if it is not within' do
    expect(invoice_item.updated_at).to eq(nil)
    expect(invoice_item.updated_at).to eq(nil)
  end
end