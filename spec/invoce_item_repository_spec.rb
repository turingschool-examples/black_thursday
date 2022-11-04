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

  it 'can create a invoice item' do
    invoice_item_repository.all << invoice_item
    invoice_item_repository.create({
    :id           => 7,
    :item_id      => 8,
    :invoice_id   => 9,
    :quantity     => 10,
    :unit_price   => BigDecimal(10.99, 4),
    :created_at   => Time.now,
    :updated_at   => Time.now
    })

    expect(invoice_item_repository.all[1]).to be_a(InvoiceItem)
    expect(invoice_item_repository.all[1].invoice_id).to eq(9)
    expect(invoice_item_repository.all[1].quantity).to eq(10)
    expect(invoice_item_repository.all[1].id).to eq(7)
  end

  it "#update updates an invoice item" do
    invoice_item_repository.all << invoice_item
    invoice_item_repository.update(6, {:quantity => 100})
      
    expect(invoice_item_repository.all[0].quantity).to eq 100
  end

  it "#update cannot update id, item_id, invoice_id, or created_at" do
    invoice_item_repository.all << invoice_item
    invoice_item_repository.update(6, {:id => 100})
      
    expect(invoice_item_repository.all[0].id).to eq 6
  end

  it "#update on unknown invoice item does nothing" do
    invoice_item_repository.all << invoice_item
    invoice_item_repository.update(100, {:quantity => 100})
      
    expect(invoice_item_repository.all[0].id).to eq 6
    expect(invoice_item_repository.find_by_id(100)).to eq nil
  end
end