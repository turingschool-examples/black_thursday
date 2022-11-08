require './lib/requirements'

RSpec.describe InvoiceItemRepository do
  let!(:invoice_item_repository){InvoiceItemRepository.new('./data/invoice_items.csv', nil)}

  it 'is an invoice item repository class' do
    expect(invoice_item_repository).to be_a(InvoiceItemRepository)
  end

  it "#all returns an array of all invoice item instances" do
      expect(invoice_item_repository.all.count).to eq 21830
    end

  it "#find_by_id finds an invoice_item by id" do
    id = 10
    expected =invoice_item_repository.find_by_id(id)

    expect(expected.id).to eq id
    expect(expected.item_id).to eq 263523644
    expect(expected.invoice_id).to eq 2
  end

  it "#find_by_id returns nil if the invoice item does not exist" do
    id = 200000
    expected = invoice_item_repository.find_by_id(id)

    expect(expected).to eq nil
  end

  it "#find_all_by_item_id finds all items matching given item_id" do
    item_id = 263408101
    expected = invoice_item_repository.find_all_by_item_id(item_id)

    expect(expected.length).to eq 11
    expect(expected.first.class).to eq InvoiceItem
  end

  it "#find_all_by_item_id returns an empty array if there are no matches" do
    item_id = 10
    expected = invoice_item_repository.find_all_by_item_id(item_id)

    expect(expected.length).to eq 0
    expect(expected.empty?).to eq true
  end

  it "#find_all_by_invoice_id finds all items matching given item_id" do
    invoice_id = 100
    expected =invoice_item_repository.find_all_by_invoice_id(invoice_id)

    expect(expected.length).to eq 3
    expect(expected.first.class).to eq InvoiceItem
  end

  it "#find_all_by_invoice_id returns an empty array if there are no matches" do
    invoice_id = 1234567890
    expected = invoice_item_repository.find_all_by_invoice_id(invoice_id)

    expect(expected.length).to eq 0
    expect(expected.empty?).to eq true
  end

  it "#create creates a new invoice item instance" do
    attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }
    invoice_item_repository.create(attributes)
    invoice_item_repository.find_by_id(21831)
    expect(invoice_item_repository.find_by_id(21831).item_id).to eq 7
  end

  it "#update updates an invoice item" do
    original_time = invoice_item_repository.find_by_id(21830).updated_at
    expect(invoice_item_repository.find_by_id(21830).quantity).to eq 4
    attributes = {
      quantity: 13
    }
    invoice_item_repository.update(21830, attributes)
    invoice_item_repository.find_by_id(21830)

    expect(invoice_item_repository.find_by_id(21830).quantity).to eq 13
    expect(invoice_item_repository.find_by_id(21830).item_id).to eq 263519844
    expect(invoice_item_repository.find_by_id(21830).updated_at).to be > original_time
  end

  it "#update cannot update id, item_id, invoice_id, or created_at" do
    attributes = {
      id: 22000,
      item_id: 32,
      invoice_id: 53,
      created_at: Time.now
    }
    invoice_item_repository.update(21830, attributes)
    expected = invoice_item_repository.find_by_id(22000)
    expect(expected).to eq nil
    expected = invoice_item_repository.find_by_id(21830)
    expect(expected.item_id).not_to eq attributes[:item_id]
    expect(expected.invoice_id).not_to eq attributes[:invoice_id]
    expect(expected.created_at).not_to eq attributes[:created_at]
  end

  it "#update on unknown invoice item does nothing" do
    invoice_item_repository.update(22000, {})
  end

  it "#delete deletes the specified invoice" do
    invoice_item_repository.delete(21830)
    expected = invoice_item_repository.find_by_id(21830)
    expect(expected).to eq nil
  end

  it "#delete on unknown invoice does nothing" do
    invoice_item_repository.delete(22000)
  end
end