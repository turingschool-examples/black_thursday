require_relative 'spec_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'

RSpec.describe InvoiceItemRepository do
  before (:each) do
    @repo = InvoiceItemRepository.new('./spec/fixtures/mock_invoice_items.csv')
  end

  it 'exists' do
    expect(@repo).to be_a(InvoiceItemRepository)
  end

  it 'returns all' do
    expect(@repo.all.length).to eq(3)
    @repo.all.each do |item|
      expect(item).to be_a(InvoiceItem)
    end
  end

  it 'returns invoice item by id number' do
    expect(@repo.find_by_id(1).item_id).to eq(10)
    expect(@repo.find_by_id(2).item_id).to eq(20)
    expect(@repo.find_by_id(20)).to eq(nil)
  end

  it 'returns invoice item by item id number' do
    ids = []
    @repo.find_all_by_item_id(10).each do |invoice_item|
      ids << invoice_item.id
    end
    expect(ids).to eq([1])

    ids = []
    @repo.find_all_by_item_id(20).each do |invoice_item|
      ids << invoice_item.id
    end
    expect(ids).to eq([2, 3])

    expect(@repo.find_all_by_item_id(50)).to eq([])
  end

  it 'returns invoice item by invoice id number' do
    ids = []
    @repo.find_all_by_invoice_id(1).each do |invoice_item|
      ids << invoice_item.id
    end
    expect(ids).to eq([1, 2])

    ids = []
    @repo.find_all_by_invoice_id(2).each do |invoice_item|
      ids << invoice_item.id
    end
    expect(ids).to eq([3])

    expect(@repo.find_all_by_invoice_id(50)).to eq([])
  end

end
