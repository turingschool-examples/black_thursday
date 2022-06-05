require_relative './spec_helper'

RSpec.describe InvoiceItemRepository do
  before :each do
    @invoice_item_repository = InvoiceItemRepository.new("./data/invoice_items.csv")
  end

  it 'is an InvoiceItemRepository' do
    expect(@invoice_item_repository).to be_instance_of(InvoiceItemRepository)
  end

  it 'returns and array of all known InvoiceItem instances' do
    expect(@invoice_item_repository.all.class).to eq(Array)
    expect(@invoice_item_repository.all.count).to eq(21830)
    expect(@invoice_item_repository.all[0].class).to eq(InvoiceItem)
  end

  it 'returns an instance of invoice item by id' do
    expect(@invoice_item_repository.find_by_id(10).item_id).to eq(263523644)
    expect(@invoice_item_repository.find_by_id(10).invoice_id).to eq(2)
    expect(@invoice_item_repository.find_by_id(200000)).to eq(nil)
  end

  it 'returns an instance by invoice id' do
    expect(@invoice_item_repository.find_all_by_invoice_id(100).length).to eq(3)
  end

  it 'creates a new invoice item instance' do
    attributes = {
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @invoice_item_repository.create(attributes)
    expect(@invoice_item_repository.find_by_id(21831).item_id).to eq(7)
  end

  it 'can update the quantity and unit price' do
    attributes = {
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @invoice_item_repository.create(attributes)
    original_time = @invoice_item_repository.find_by_id(21831).updated_at
    @invoice_item_repository.update(21831, { quantity: 13})
    expect(@invoice_item_repository.find_by_id(21831).quantity).to eq(13)
    expect(@invoice_item_repository.find_by_id(21831).item_id).to eq 7
    expect(@invoice_item_repository.find_by_id(21831).updated_at).to be > original_time

    @invoice_item_repository.update(21831, { unit_price: BigDecimal(7.99, 4)})
    expect(@invoice_item_repository.find_by_id(21831).unit_price).to eq(BigDecimal(7.99, 4))

    expect(@invoice_item_repository.update(21831, { item_id: 21888})).to eq(nil)
  end

  it 'can delete an InvoiceItem' do
    attributes = {
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @invoice_item_repository.create(attributes)
    @invoice_item_repository.delete(21831)
    expect(@invoice_item_repository.find_by_id(21831)).to eq(nil)
  end
end
