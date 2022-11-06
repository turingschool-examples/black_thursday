require './lib/invoice_item_repository'

RSpec.describe InvoiceItemRepository do
  let(:iir) { InvoiceItemRepository.new }
  it 'creates a new InvoiceItem, with attributes' do
    item1 = iir.create({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })

    expect(item1).to be_a(InvoiceItem)
    expect(item1.id).to eq(6)
    expect(item1.item_id).to eq(7)
    expect(item1.invoice_id).to eq(8)
    expect(item1.quantity).to eq(1)
    expect(item1.unit_price).to eq(10.99)
    expect(item1.created_at).to be_a(Time)
    expect(item1.updated_at).to be_a(Time)
  end
  
  it 'creates InvoiceItems, id + 1' do
    item1 = iir.create({
        :id => 6,
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      })
    item2 = iir.create({
        :id => 4,
        :item_id => 3,
        :invoice_id => 2,
        :quantity => 5,
        :unit_price => BigDecimal(14.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      })
      expect(item1).to be_a(InvoiceItem)
      expect(item1.id).to eq(6)
      expect(item2).to be_a(InvoiceItem)
      expect(item2.id).to eq(7)
  end


  it 'lists all instances of InvoiceItems' do
    item1 = iir.create({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
  item2 = iir.create({
      :id => 4,
      :item_id => 3,
      :invoice_id => 2,
      :quantity => 5,
      :unit_price => BigDecimal(14.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })

    expect(iir.all).to eq([item1, item2])
  end

  it 'finds InvoiceItems by id' do
    item1 = iir.create({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
  item2 = iir.create({
      :id => 4,
      :item_id => 3,
      :invoice_id => 2,
      :quantity => 5,
      :unit_price => BigDecimal(14.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
    expect(iir.all).to eq([item1, item2])
    expect(iir.find_by_id(7)).to eq(item2)
  end

  it 'finds all InvoiceItems by Item id' do
    item1 = iir.create({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
  item2 = iir.create({
      :id => 4,
      :item_id => 7,
      :invoice_id => 2,
      :quantity => 5,
      :unit_price => BigDecimal(14.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })

    expect(iir.find_all_by_item_id(1)).to eq([])
    expect(iir.find_all_by_item_id(7)).to eq([item1, item2])
  end

  it 'finds all InvoiceItems by Invoice id' do
    item1 = iir.create({
      :id => 6,
      :item_id => 3,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
  item2 = iir.create({
      :id => 4,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 5,
      :unit_price => BigDecimal(14.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })

    expect(iir.find_all_by_invoice_id(1)).to eq([])
    expect(iir.find_all_by_invoice_id(8)).to eq([item1, item2])
  end

  it 'updates an InvoiceItem' do
    item1 = iir.create({
      :id => 6,
      :item_id => 3,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })

    iir.update(6, {
      :id => 4,
      :item_id => 7,
      :invoice_id => 6,
      :quantity => 5,
      :unit_price => BigDecimal(14.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })

    expect(item1.id).to eq(6)
    expect(item1.item_id).to eq(3)
    expect(item1.invoice_id).to eq(8)
    expect(item1.quantity).to eq(5)
    expect(item1.unit_price).to eq(14.99)
  end

  it 'deletes InvoiceItems by id' do
    item1 = iir.create({
      :id => 6,
      :item_id => 3,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
  item2 = iir.create({
      :id => 4,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 5,
      :unit_price => BigDecimal(14.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })

    expect(iir.all).to eq([item1, item2])

    iir.delete(6)

    expect(iir.all).to eq([item2])
  end
end