require_relative 'spec_helper'
require_relative '../lib/item_repository'
require_relative '../lib/item'

RSpec.describe ItemRepository do
  before (:each) do
    @repo = ItemRepository.new('./spec/fixtures/mock_items.csv')
  end

  it 'exists' do
    expect(@repo).to be_a(ItemRepository)
  end

  it 'returns all' do
    expect(@repo.all.length).to eq(50)
    @repo.all.each do |item|
      expect(item).to be_a(Item)
    end
  end

  it 'returns item by id number' do
    expect(@repo.find_by_id(263396013).name).to eq('Free standing Woden letters')
    expect(@repo.find_by_id(263397059).name).to eq('Etre ailleurs')
    expect(@repo.find_by_id(20)).to eq(nil)
  end

  it 'returns item by name' do
    expect(@repo.find_by_name('Free standing Woden letters').id).to eq(263396013)
    expect(@repo.find_by_name('Etre ailleurs').id).to eq(263397059)
    expect(@repo.find_by_name('baseball hat')).to eq(nil)
  end

  it 'returns item by description' do
    item_names = []
    @repo.find_all_with_description('Acrylique sur toile et collage.').each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(["Moyenne toile"])

    expect(@repo.find_all_with_description('for basketball')).to eq([])
  end

  it 'returns items by price' do
    item_names = []
    @repo.find_all_by_price(0.12e2).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(["510+ RealPush Icon Set", "Bootees"])

    item_names = []
    @repo.find_all_by_price(0.11e3).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(["Antique Rocking Horse"])

    expect(@repo.find_all_by_price(0.2e0)).to eq([])
  end

  it 'returns items by price in a range' do
    item_names = []
    @repo.find_all_by_price_in_range(0.0..0.5e1).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(["A Variety of Fragrance Oils for Oil Burners, Potpourri, Resins + More, Lavender, Patchouli, Nag Champa, Rose, Vanilla, White Linen, Angel"])

    item_names = []
    @repo.find_all_by_price_in_range(0.5e1..0.11e2).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(["Free standing Woden letters", "Kindersocken (Söckchen), hangestrickt, Länge ca.15 cm, beige (eierschalenfarben)"])

    expect(@repo.find_all_by_price_in_range(0.0..0.2e1)).to eq([])
  end

  it 'returns items by merchant id' do
    item_names = []
    @repo.find_all_by_merchant_id(12334257).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(['Wooden pen and stand'])

    item_names = []
    @repo.find_all_by_merchant_id(12334365).each do |item|
      item_names << item.name
    end
    expect(item_names).to eq(["Green Footed Ceramic Bowl", "Spalted Maple Heart Box", "Ironstone Pitcher (Small)", "Antique Rocking Horse"])

    expect(@repo.find_all_by_merchant_id(50)).to eq([])
  end

  it 'creates new id number' do
    expect(@repo.new_item_id_number).to eq(263401882)
  end

  it 'creates new item instance' do
    attributes = {
      :name        => 'jersey',
      :description => 'clothing',
      :unit_price  => 20,
      }
    @repo.create(attributes)

    expect(@repo.all.length).to eq(51)
    expect(@repo.find_by_id(263401882).name).to eq('jersey')
    expect(@repo.find_by_id(263401882).description).to eq('clothing')
    expect(@repo.find_by_id(263401882).unit_price).to eq(0.2e0)
  end

  it 'updates item attributes by id' do
    new_attributes = {
      name: 'metal bat',
      description: 'for practice',
      unit_price: BigDecimal(20, 4)
    }
    og_time = @repo.find_by_id(263401045).updated_at
    @repo.update(263401045, new_attributes)

    expect(@repo.find_by_id(263401045).name).to eq('metal bat')
    expect(@repo.find_by_id(263401045).description).to eq('for practice')
    expect(@repo.find_by_id(263401045).unit_price).to eq(0.2e2)
    expect(@repo.find_by_id(263401045).updated_at).to_not eq(og_time)
  end

  it 'deletes item by id' do
    @repo.delete(263401045)

    expect(@repo.all.length).to eq(49)
    expect(@repo.find_by_id(263401045)).to eq(nil)
  end

  it 'can access item unit price to dollars method' do
    dollars = @repo.find_by_id(263401045).unit_price_to_dollars
    expect(dollars).to eq(25.0)
  end

  it 'groups items by merchant' do
    merchants = @repo.group_items_by_merchant
    item_ids_by_merchant = Hash.new { |key, value| key[value] = [] }

    merchants.each do |merchant, items|
      items.each do |item|
        expect(item).to be_a(Item)
        item_ids_by_merchant[merchant] << item.id
      end
    end

    expect(item_ids_by_merchant[12334185]).to eq([263395617, 263395721, 263396013])
  end

  it '.items_per_merchant' do
    expect(@repo.items_per_merchant[1]).to eq(3)
  end

  it 'returns the number of merchants' do
    expect(@repo.number_of_merchants).to eq(24)
  end

  it 'returns total merchant items by merchant' do
    expect(@repo.total_items_by_merchant(12334195)).to eq(12)
  end

  it 'returns price total by merchant' do
    expect(@repo.merchant_price_sum(12334195)).to eq(BigDecimal(5398))
  end

  it 'returns sum of all item prices' do
    expect(@repo.items_total_price).to eq(0.768343e4)
  end

  it 'returns all items by price' do
    expect(@repo.all_items_by_price.length).to eq(50)
  end
end
