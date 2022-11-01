require './lib/itemrepository'
require './lib/item'

RSpec.describe ItemRepository do
  let(:item_repo) {ItemRepository.new}

  it 'exists' do
    expect(item_repo).to be_a ItemRepository
  end

  describe '#find_by_name' do
    it 'returns either nil or an instance of Item' do
      expect(item_repo.find_by_name("Pencil")).to be nil

      item = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
      })
      item_repo = ItemRepository.new([item])

      expect(item_repo.find_by_name("Pencil")).to eq item
    end
  end
end