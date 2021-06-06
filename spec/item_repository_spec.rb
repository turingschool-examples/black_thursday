require_relative './spec_helper'

RSpec.describe ItemRepository do
  context 'instantiation' do
    it 'exists' do
      sales_engine = SalesEngine.new({ items: 'spec/fixtures/items.csv', merchants: 'spec/fixtures/merchants.csv' })
      ir = ItemRepository.new('spec/fixtures/items.csv', sales_engine)
      expect(ir).to be_a(ItemRepository)
    end
  end

  context 'methods' do
    before :each do
      @sales_engine = SalesEngine.new({ items: 'spec/fixtures/items.csv', merchants: 'spec/fixtures/merchants.csv' })
      @ir = ItemRepository.new('spec/fixtures/items.csv', @sales_engine)
      @ir.generate
      @item1 = @ir.all[1]
      @item2 = @ir.all[-1]
    end

    it 'generates Item instances' do
      expect(@item1.id).to eq(2)
      expect(@item1.name).to eq('pencils')
      expect(@item2.id).to eq(20)
      expect(@item2.name).to eq('mattress')
    end

    it 'returns item with matching ID or nil' do
      expect(@ir.find_by_id(2)).to eq(@item1)
      expect(@ir.find_by_id(20)).to eq(@item2)
      expect(@ir.find_by_id(268_666_423)).to eq(nil)
    end

    it 'returns item with matching name or nil' do
      expect(@ir.find_by_name('pencils')).to eq(@item1)
      expect(@ir.find_by_name('mattress')).to eq(@item2)
      expect(@ir.find_by_name('footballs')).to eq(nil)
    end

    it 'returns all items that match provided description' do
      description = 'You can write with them'
      expected = @ir.find_all_with_description(description)
      expect(@ir.find_all_with_description(description)).to eq([@item1])
      expect(expected.first.id).to eq(2)
    end

    it 'returns items by unit price' do
      price = BigDecimal(12)
      expected = @ir.find_all_by_price(price)
      item4 = @ir.all[-4]

      expect(expected).to eq([item4])
      expect(@ir.find_all_by_price(2000)).to eq([])
    end

    it 'returns items within given price range' do
      range = (11.00..13.00)
      expected = @ir.find_all_by_price_in_range(range)
      item3 = @ir.all[3]
      item4 = @ir.all[-4]

      expect(expected).to eq([item3, item4])
      expect(@ir.find_all_by_price_in_range(2000..3000)).to eq([])
    end

    it 'returns items by merchant id' do
      expect(@ir.find_all_by_merchant_id(0o2)).to eq([@item1])
      expect(@ir.find_all_by_merchant_id(20)).to eq([@item2])
      expect(@ir.find_all_by_merchant_id(111_111_111)).to eq([])
    end

    it 'creates a new item instance with given attributes' do
      # allow(Time).to receive(:strftime).and_return("current time")
      # allow(Time).to receive(:now).and_return("current time")
      attributes = {
        name: 'Airplanes',
        description: 'They fly super dooper',
        unit_price: BigDecimal(1000),
        created_at: Time.now.to_s,
        updated_at: Time.now.to_s,
        merchant_id: 21
      }

      @ir.create(attributes)
      new_item = @ir.all.last
      expect(new_item.id).to eq(21)
      expect(@ir.all.length).to eq(21)
      expect(new_item.created_at.class).to eq(Time)
      expect(new_item.updated_at).to eq(new_item.created_at)
      expect(@ir.find_by_id(21).name).to eq('Airplanes')
      @ir.create(attributes)
      newer_item = @ir.all.last
      expect(newer_item.id).to eq(22)
    end

    it 'cannot update id if id does not exist' do
      attributes = {
        id: 13_000_000
      }

      expected = @ir.update(123_456, attributes)

      expect(expected).to eq(nil)
    end

    it 'updates item by id with given attributes' do
      # allow(Time).to receive(:strftime).and_return("current time")

      attributes = {
        name: 'pens',
        description: 'They cant be erased',
        unit_price: BigDecimal(5)

      }
      variable_name = @item1.updated_at
      @ir.update(2, attributes)

      expect(@item1.name).to eq('pens')
      expect(@item1.description).to eq('They cant be erased')
      expect(@item1.unit_price).to eq(5)
      expect(@item1.updated_at).to be_an_instance_of(Time)
      expect(variable_name).to_not eq(@item1.updated_at)
    end

    it 'delete item by id' do
      expect(@ir.all.length).to eq(20)
      expect(@ir.delete(0o2)).to eq(@item1)
      expect(@ir.all.length).to eq(19)
    end

    it 'can inspect rows' do
      expect(@ir.inspect).to eq('#<ItemRepository 20 rows>')
    end
  end
end
