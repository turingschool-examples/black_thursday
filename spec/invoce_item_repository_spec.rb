require './lib/item_repository'
require './lib/item'
require './lib/invoice_item_repository'

RSpec.describe InvoiceItemRepository do
  let(:invoice_item_repository) {InvoiceItemRepository.new}
  let(:invoice_item) {InvoiceItem.new({
    :id           => 6,
    :item_id      => 7,
    :invoice_id   => 8,
    :quantity     => 1,
    :unit_price   => BigDecimal(10.99, 4),
    :created_at   => Time.now,
    :updated_at   => Time.now
  })}
   
  it 'exists' do
    expect(invoice_item_repository).to be_a InvoiceItemRepository
  end

  it 'can find by id' do
    expect(invoice_item_repository.find_by_id(5)).to be nil

    invoice_item_repository.all << invoice_item
    expect(invoice_item_repository.find_by_id(6)).to be invoice_item
  end

  it 'can find all by item id' do
    expect(invoice_item_repository.find_all_by_item_id(5)).to eq []

    invoice_item_repository.all << invoice_item
    expect(invoice_item_repository.find_all_by_item_id(7)).to be {invoice_item}
  end

  it 'can find all by invoice id' do
    expect(invoice_item_repository.find_all_by_invoice_id(5)).to eq []

    invoice_item_repository.all << invoice_item
    expect(invoice_item_repository.find_all_by_invoice_id(8)).to be {invoice_item}
  end

  it 'can create a repository' do
    expect(invoice_item_repository.create({:id           => 6,
                                            :item_id      => 7,
                                            :invoice_id   => 8,
                                            :quantity     => 1,
                                            :unit_price   => BigDecimal(10.99, 4),
                                            :created_at   => Time.now,
                                            :updated_at   => Time.now})).to be_a {InvoiceItem}
  end
end