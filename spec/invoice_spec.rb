require './lib/invoice_repository'
require './lib/invoice'

RSpec.describe Invoice do
  let!(:invoice) {Invoice.new({
    :id => 1,
    :customer_id => 1,
    :merchant_id => 28282828,
    :status => :pending,
    :created_at => Time.now,
    :updated_at => Time.now
  }, nil)}

  it 'is an invoice class' do
    expect(invoice).to be_a(Invoice)
  end

  it 'returns all the invoice instances' do
    expect(invoice.all).to eq([])
  end

  it 'can return an invoice by id' do
    expect(invoice.find_by_id()).to eq()
  end

  it 'returns nil if it is not within' do
    expect(invoice.find_by_id()).to eq(nil)
    expect(invoice.find_by_id()).to eq(nil)
  end

  it 'can return the customer id' do
    expect(invoice.find_all_by_customer_id()).to eq()
  end

  it 'returns nil if it is not within' do
    expect(invoice.find_all_by_customer_id()).to eq(nil)
    expect(invoice.find_all_by_customer_id()).to eq(nil)
  end

  it 'can return the merchants id' do
    expect(invoice.find_all_by_merchant_id()).to eq()
  end

  it 'returns nil if it is not within' do
    expect(invoice.find_all_by_merchant_id()).to eq(nil)
    expect(invoice.find_all_by_merchant_id()).to eq(nil)
  end

  it 'can return the status' do
    expect(invoice.status).to eq()
  end

  it 'returns nil if it is not within' do
    expect(invoice.status).to eq(nil)
    expect(invoice.status).to eq(nil)
  end

  it 'can return the time instance when item was first created' do
    expect(invoice.created_at).to eq()
  end

  it 'returns nil if it is not within' do
    expect(invoice.created_at).to eq(nil)
    expect(invoice.created_at).to eq(nil)
  end

  it 'can return the time for when the item was last modified' do
    expect(invoice.updated_at).to eq()
  end

  it 'returns nil if it is not within' do
    expect(invoice.updated_at).to eq(nil)
    expect(invoice.updated_at).to eq(nil)
  end
end















# id - returns the integer id
# customer_id - returns the customer id
# merchant_id - returns the merchant id
# status - returns the status
# created_at - returns a Time instance for the date the item was first created
# updated_at - returns a Time instance for the date the item was last modified