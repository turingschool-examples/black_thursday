require './lib/itemrepository'
require './lib/item'

RSpec.describe ItemRepository do
  let(:item_repo) {ItemRepository.new}
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
    expect(item_repo).to be_a ItemRepository
  end

  describe '#find_by_name' do
    it 'returns either nil or an instance of Item' do
      expect(item_repo.find_by_name("Pencil")).to be nil

      item_repo = ItemRepository.new([item1])

      expect(item_repo.find_by_name("Pencil")).to eq item1
    end
  end

  describe '#find_all_with_description' do
    it 'returns an array of all items involving description' do
      expect(item_repo.find_all_with_description("write")).to eq []

      item_repo = ItemRepository.new([item1,item2,item3])

      expect(item_repo.find_all_with_description("write")).to eq [item1,item3]
    end
  end

  describe '#find_all_by_price' do
    it 'returns an array of items with that price' do
      expect(item_repo.find_all_by_price(BigDecimal(10.99,4))).to eq []

      item_repo = ItemRepository.new([item1,item2,item3])

      expect(item_repo.find_all_by_price(BigDecimal(10.99,4))).to eq [item1,item2]
    end
  end

  describe '#find_all_by_price_in_range' do
    it 'returns an array of all items in price range' do
      item_repo = ItemRepository.new([item1,item2,item3,item4])

      expect(item_repo.find_all_by_price_in_range(0..10)).to eq []
      expect(item_repo.find_all_by_price_in_range(10..21)).to eq [item1,item2,item3]
      expect(item_repo.find_all_by_price_in_range(20..30)).to eq [item3,item4]
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'returns items with specified merchant id' do
      item_repo = ItemRepository.new([item1,item2,item3,item4])

      expect(item_repo.find_all_by_merchant_id(2)).to eq [item1,item2]
      expect(item_repo.find_all_by_merchant_id(3)).to eq [item3,item4]
    end
  end
end