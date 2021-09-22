require './lib/invoice_item_repo'
# require './lib/invoice'
require 'csv'

RSpec.describe do

  it 'exists' do
    ii = InvoiceItem.new(row)
    invoice_items_path = './data/invoice_items.csv'
    invoice_items_repository = InvoiceItemRepository.new(invoice_items_path)
    # require "pry"; binding.pry
    expect(invoice_item_repository).to be_an_instance_of(InvoiceItemRepository)
  end

  it 'can return and array of all known invoice items' do
    invoice_items_path = './data/invoice_items.csv'
    invoice_items_repository = InvoiceItemRepository.new(invoice_items_path)

    expect(invoice_items_repository.all[0]).to be_an_instance_of(InvoiceItem)
    expect(invoice_items_repository.all.count).to eq(21830)
  end

  it 'can find by id' do
    invoice_items_path = './data/invoice_items.csv'
    invoice_items_repository = InvoiceItemRepository.new(invoice_items_path)
    example_invoice_item = sales_engine.invoice_items.find_by_id(6)

    expect(invoice_items_repository.find_by_id).to eq example_invoice_item
    expect(invoice_items_repository.find_by_id(99898013042)).to eq([])
  end

  it 'can find all by item id' do
    invoice_items_path = './data/invoice_items.csv'
    invoice_items_repository = InvoiceItemRepository.new(invoice_items_path)

    example_invoice_item = sales_engine.invoice_items.find_all_by_item_id(6)

    expect(invoice_items_repository.find_all_by_item_id).to eq example_invoice_item
    expect(invoice_items_repository.find_all_by_item_id(99898013042)).to eq([])
  end

  it 'can find all by invoice id' do
    invoice_items_path = './data/invoice_items.csv'
    invoice_items_repository = InvoiceItemRepository.new(invoice_items_path)
    example_invoice_item = sales_engine.invoice_items.find_all_by_invoice_id(6)

    #may need example with invoice id vs item id

    expect(invoice_items_repository.find_all_by_invoice_id).to eq example_invoice_item
    expect(invoice_items_repository.find_all_by_invoice_id(99898013042)).to eq([])
  end
  
  it 'can create attributes' do
    invoice_items_path = './data/invoice_items.csv'
    invoice_items_repository = InvoiceItemRepository.new(invoice_items_path)
    example_invoice_item = sales_engine.invoice_items.find_by_id(6)

    expect(invoice_items_repository.find_by_id(21831)).to eq(nil)
    invoice_items_repository.create({:id => 21831})


    expect(invoice_items_repository.find_by_id(21831)).not_to eq(nil)
    expect(invoice_items_repository.all.last.id).to eq(21831)
  end

  it 'can update attributes' do
    invoice_items_path = './data/invoice_items.csv'
    invoice_items_repository = InvoiceItemRepository.new(invoice_items_path)
    example_invoice_item = sales_engine.invoice_items.find_by_id(6)

    expect(invoice_items_repository.find_by_id(21831)).to eq(nil)
    invoice_items_repository.create({:id => 21831})
    invoice_items_repository.update({:id => 21831, :quantity => 10, :unit_price => 1300})


    expect((invoice_items_repository.find_by_id(21831)).quantity).to eq(10)
    expect((invoice_items_repository.find_by_id(21831)).unit_price).to eq(1300)
  end

  it 'can delete an invoice instance' do
    invoice_items_path = './data/invoice_items.csv'
    invoice_items_repository = InvoiceItemRepository.new(invoice_items_path)
    example_invoice_item = sales_engine.invoice_items.find_by_id(6)

    invoice_items_repository.create({:id => 21831})
    expect(invoice_items_repository.all.count).to eq 21831
    merchant_repository.delete(21831)
    expect(invoice_items_repository.all.count).to eq 21830
  end
end
