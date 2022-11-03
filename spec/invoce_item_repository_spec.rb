require './lib/item_repository'
require './lib/item'
require './lib/invoice_item_repository'

RSpec.describe InvoiceItemRepository do
  let(:invoice_item_repo) {InvoiceItemRepository.new}
  let(:item1) {Item.new({
    :id          => 1,
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 2
  })}
  let(:item2) {Item.new({
    :id          => 2,
    :name        => "Eraser",
    :description => "You can use it to erase things",
    :unit_price  => BigDecimal(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 2
  })}
  let(:item3) {Item.new({
    :id          => 3,
    :name        => "Pen",
    :description => "You can write but not erase",
    :unit_price  => BigDecimal(20.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 3
  })}
  let(:item4) {Item.new({
    :id          => 4,
    :name        => "Fountain Pen",
    :description => "A nicer pen",
    :unit_price  => BigDecimal(22.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 3
  })}

  it 'exists' do
    expect(invoice_item_repo).to be_a InvoiceItemRepository
  end

  it 'can find by id' do
  end

  it 'can find all by item id' do
  end

  it 'can find all by invoice id' do
  end

  it 'can create a repository' do
  end
end