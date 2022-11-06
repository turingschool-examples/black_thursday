require './lib/invoice_item_repository'

RSpec.describe InvoiceItemRepository do
  let(:iir) { InvoiceItemRepository.new }

  let(:item1) { iir.create({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now})}

  let(:item2) { iir.create({
      :id => 4,
      :item_id => 3,
      :invoice_id => 2,
      :quantity => 5,
      :unit_price => BigDecimal(14.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })}

  it 'creates a new InvoiceItem, with attributes' do
    expect(item1).to be_a(InvoiceItem)
    expect(item1.id).to eq(6)
    expect(item1.item_id).to eq(7)
    expect(item1.invoice_id).to eq(8)
    expect(item1.quantity).to eq(1)
    expect(item1.unit_price).to eq(10.99)
    expect(item1.created_at).to be_a(Time)
    expect(item1.updated_at).to be_a(Time)
  end
  
  it 'lists all instances of InvoiceItems' do
    expect(iir.all).to eq([item1, item2])
  end

  it 'finds InvoiceItems by id' do
    expect(iir.all).to eq([item1, item2])
    expect(iir.find_by_id(4)).to eq(item2)
  end
  
  it 'deletes InvoiceItems by id' do
    expect(iir.all).to eq([item1, item2])
    iir.delete(6)
    expect(iir.all).to eq([item2])
  end

  context 'populate repository' do
    before(:each) { 
      @item3 = iir.create({
      :id => 6,
      :invoice_id => 8,
      :item_id => 7,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now})
    }

  it 'creates InvoiceItems, id + 1' do
    new_item = iir.create({
        :invoice_id => 2,
        :item_id => 3,
        :quantity => 5,
        :unit_price => BigDecimal(14.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      })
      expect(new_item).to be_a(InvoiceItem)
      expect(new_item.id).to eq(7)
  end


  it 'finds all InvoiceItems by Item id' do
    expect(iir.find_all_by_item_id(1)).to eq([])
    expect(iir.find_all_by_item_id(7)).to eq([@item3])
  end

  it 'finds all InvoiceItems by Invoice id' do
    expect(iir.find_all_by_invoice_id(1)).to eq([])
    expect(iir.find_all_by_invoice_id(8)).to eq([@item3])
  end

  it 'updates an InvoiceItem' do
    iir.update(6, {
      :quantity => 5,
      :unit_price => BigDecimal(14.99, 4),
    })

    expect(@item3.quantity).to eq(5)
    expect(@item3.unit_price).to eq(14.99)
  end
end
end