require_relative './spec_helper'

RSpec.describe ItemRepository do
  context 'instantiation' do
    it 'exists' do
      ir = ItemRepository.new('spec/fixtures/items.csv')
      expect(ir).to be_a(ItemRepository)
    end
  end

  context 'methods' do
    before :each do
      @ir = ItemRepository.new('spec/fixtures/items.csv')
      @item1 = @ir.all[1]
      @item2 = @ir.all[-1]
    end

    it 'generates Item instances' do
      expect(@item1.id).to eq(263395295)
      expect(@item1.name).to eq('pencils')
      expect(@item2.id).to eq(268716492)
      expect(@item2.name).to eq('mattress')
      expect(@ir.all).to be_a(Array)
    end

    it 'returns item with matching ID or nil' do
      expect(@ir.find_by_id(263395295)).to eq(@item1)
      expect(@ir.find_by_id(268716492)).to eq(@item2)
      expect(@ir.find_by_id(26866642)).to eq(nil)
    end

    it 'returns item with matching name or nil' do
      expect(@ir.find_by_name('pencils')).to eq(@item1)
      expect(@ir.find_by_name('mattress')).to eq(@item2)
      expect(@ir.find_by_name('footballs')).to eq(nil)
    end

    it 'returns all items that match provided description' do
      expect(@ir.find_all_with_description('You can write with them')).to eq([@item1])
      expect(@ir.find_all_with_description('You can sleep on it')).to eq([@item2])
      expect(@ir.find_all_with_description('You can fight lions with them')).to eq([])
    end

    it 'returns items by unit price' do
      expect(@ir.find_all_by_price(12)).to eq([@item1])
      expect(@ir.find_all_by_price(400)).to eq([@item2])
      expect(@ir.find_all_by_price(2000)).to eq([])
    end

    it 'returns items within given price range' do
      expect(@ir.find_all_by_price_in_range(11..13)).to eq([@item1])
      expect(@ir.find_all_by_price_in_range(350..450)).to eq([@item2])
      expect(@ir.find_all_by_price_in_range(2000..3000)).to eq([])
    end
  end
end
