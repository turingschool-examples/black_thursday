require './lib/invoice_repository'
require './lib/invoice'

RSpec.describe Invoice do
  let!(:invoice) {Invoice.new()}

  it 'is an invoice class' do
    expect(invoice).to be_a(Invoice)
  end

  it 'can return an invoice by id' do

  end

  it 'returns nil if it is not within' do

  end

  it 'can return the customer id' do

  end

  it 'returns nil if it is not within' do

  end

  it 'can return the merchants id' do

  end

  it 'returns nil if it is not within' do

  end

  it 'can return the status' do

  end

  it 'returns nil if it is not within' do

  end

  it 'can return the time instance when item was first created' do

  end

  it 'returns nil if it is not within' do

  end

  it 'can return the time for when the item was last modified' do

  end

  it 'returns nil if it is not within' do

  end
end















# id - returns the integer id
# customer_id - returns the customer id
# merchant_id - returns the merchant id
# status - returns the status
# created_at - returns a Time instance for the date the item was first created
# updated_at - returns a Time instance for the date the item was last modified