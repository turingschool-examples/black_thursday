require_relative 'spec_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'
require 'bigdecimal'

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

  it 'creates new invoice item id number' do
    expect(@repo.new_invoice_item_id).to eq(4)
  end

  it 'creates new invoice item instance' do
    attributes = {
      :item_id => 21,
      :invoice_id => 3,
      :quantity => 20,
      :unit_price => 1199,
    }
    @repo.create(attributes)

    expect(@repo.all.length).to eq(4)
    expect(@repo.find_by_id(4).item_id).to eq(21)
    expect(@repo.find_by_id(4).invoice_id).to eq(3)
    expect(@repo.find_by_id(4).quantity).to eq(20)
    expect(@repo.find_by_id(4).unit_price).to eq(0.1199e2)
  end

  it 'updates invoice item attributes by id' do
    new_attributes = {
      :quantity => 50,
      :unit_price => BigDecimal(14.55, 4)
    }
    og_time = @repo.find_by_id(2).updated_at
    @repo.update(2, new_attributes)

    expect(@repo.find_by_id(2).quantity).to eq(50)
    expect(@repo.find_by_id(2).unit_price).to eq(0.1455e2)
    expect(@repo.find_by_id(2).updated_at).to_not eq(og_time)
  end

  it 'deletes invoice item by id' do
    @repo.delete(2)

    expect(@repo.all.length).to eq(2)
    expect(@repo.find_by_id(2)).to eq(nil)
  end

  it 'can access invoie item unit price to dollars method' do
    dollars = @repo.find_by_id(1).unit_price_to_dollars
    expect(dollars).to eq(10)
  end
end
