require './lib/requirements'

RSpec.describe ItemRepository do
  # let!(:time_now) {Time.now}
  let!(:item_repository) {ItemRepository.new("./data/items.csv", nil)}

  it 'is an item repository class' do
    expect(item_repository).to be_a(ItemRepository)
  end

  it 'returns all item instances' do
    expect(item_repository.all.length).to eq(1367)
  end

  it 'can find item by id' do
    expect(item_repository.find_by_id(263397785)).to eq(item_repository.all[13])
    expect(item_repository.find_by_id(5)).to eq(nil)
  end

  it 'can find item by name' do
    expect(item_repository.find_by_name("Wooden pen and stand")).to eq(item_repository.all[14])
    expect(item_repository.find_by_name("WoOdeN pEn aNd sTanD")).to eq(item_repository.all[14])
    expect(item_repository.find_by_name("Textbook")).to eq(nil)
  end

  it 'can find all items with included description' do
    expect(item_repository.find_all_with_description("Acrylique sur toile, mesurant environs 80/50cm.")).to eq([item_repository.all[30]])
    expect(item_repository.find_all_with_description("Acrylique sur toile, mesurant environs 80/50cm.")).to eq([item_repository.all[30]])
    expect(item_repository.find_all_with_description("You can erase things")).to eq([])
  end

  it 'can find all items by a given price' do
    expect(item_repository.find_all_by_price(1.99)).to eq([item_repository.all[94]])
    expect(item_repository.find_all_by_price(0.05)).to eq([])
  end

  it 'can find all items by price, within a range' do
    expect(item_repository.find_all_by_price_in_range(5.93..5.97)).to eq([item_repository.all[543], item_repository.all[1271]])
    expect(item_repository.find_all_by_price_in_range(0.5..0.7)).to eq([])
  end

  it 'can find all items that are a merchants (id)' do
    expect(item_repository.find_all_by_merchant_id("12334105")).to eq([item_repository.all[4], item_repository.all[665], item_repository.all[671]])
    expect(item_repository.find_all_by_merchant_id(5)).to eq([])
  end

  it 'can create a new item by supplying the attributes and it has the highest id + 1' do
    expect(item_repository.all.last.name).to eq("Minty Green Knit Crochet Infinity Scarf")
    expect(item_repository.all.last.id).to eq(263567474)

    item_repository.create(
      {
      :id => 0,
      :name => "Stapler", 
      :description => "You can use this to staple things", 
      :unit_price => BigDecimal(12.00, 4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
     }
    )
    expect(item_repository.all.last.name).to eq("Stapler") 
    expect(item_repository.all.last.id).to eq(263567475)
  end

  it 'can update an item by the id, giving new attributes' do
    expect(item_repository.all[10].updated_at).to eq(Time.parse("1988-09-01 17:09:25 UTC"))
    item_repository.update(263397163, {
      :name => "Mechanical Pencil",
      :description => "You can use it to write things down",
      :unit_price => 9.99
      })

    expect(item_repository.all[10].name).to eq("Mechanical Pencil")
    expect(item_repository.all[10].description).to eq("You can use it to write things down")
    expect(item_repository.all[10].unit_price).to eq(9.99)
    expect(item_repository.all[10].created_at).to eq(Time.parse("2016-01-11 10:51:02 UTC"))
    expect(item_repository.all[10].updated_at).not_to eq(Time.parse("1988-09-01 17:09:25 UTC"))
  end

  it 'can delete an item by supplied id' do
    expect(item_repository.all.length).to eq(1367)

    item_repository.delete(263397163)
 
    expect(item_repository.all.length).to eq(1366)
  end
end