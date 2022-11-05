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
    require 'pry'; binding.pry
    expect(invoice_item_repository).to be_a(InvoiceItemRepository)
  end
  it 'returns all known invoice items in ana array' do
    expect(invoice_item_repository.all).to eq([])
  end

  it 'can return nil if it is not within' do
    expect(invoice_item_repository.all).to eq(nil)
    expect(invoice_item_repository.all).to eq(nil)
  end

  it 'returns an invoice item with matching id' do
    expect(invoice_item_repository.find_by_id()).to eq()
  end

  it 'can return nil if it is not within' do 
    expect(invoice_item_repository.find_by_id()).to eq(nil)
    expect(invoice_item_repository.find_by_id()).to eq(nil)
  end

  it 'can return all the matching item id' do
    expect(invoice_item_repository.find_all_by_item_id()).([])
  end

  it 'can return nil if it is not within' do
    expect(invoice_item_repository.find_all_by_item_id()).(nil)
    expect(invoice_item_repository.find_all_by_item_id()).(nil)
  end

  it 'returns all the matching invoice id' do
    expect(invoice_item_repository.find_all_by_invoice_id()).to eq([])
  end

  it 'can return nil if it is not within' do
    expect(invoice_item_repository.find_all_by_invoice_id()).to eq(nil)
    expect(invoice_item_repository.find_all_by_invoice_id()).to eq(nil)
  end

  it 'can create a new invoice instance with attributes' do
  expect(invoice_item_repository.create()).to eq()
end

  it 'gives the new invoice instance the highest id + 1' do
    expect(invoice_item_repository.all.last.id).to eq()

    invoice_item_repository.create()

    expect(invoice_item_repository.all.last.id).to eq()
  end

  it 'can update a merchant (by id) with new attributes' do
  #will also change the invoices updated_at_attribute to current time
    expect(invoice_item_repository.find_by_id().name).to eq()

    invoice_item_repository.update(',')

    expect(invoice_item_repository.find_by_id().name).to eq()
  end

  it 'can delete an invoice instance by supplied id' do
    expect(invoice_item_repository.all.length).to eq()
    expect(invoice_item_repository.all).to eq()

    invoice_item_repository.delete()

    expect(invoice_item_repository.all.length).to eq()
    expect(invoice_item_repository.all).to eq()
  end
end