require 'csv'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/item'

RSpec.describe SalesEngine do
  let!(:sales_engine) {SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"})}
  it 'exists' do
    expect(sales_engine).to be_a(SalesEngine)
  end

  it 'has common roots to their repositories' do
    expect(sales_engine.items).to be_a(ItemRepository)
    expect(sales_engine.merchants).to be_a(MerchantRepository)
  end

  it 'can perform ItemRepository methods' do
    ir = sales_engine.items
    require 'pry'; binding.pry
    expect(ir.find_by_id(263397785)).to eq(ir.all[13])
    expect(ir.find_by_name("Wooden pen and stand")).to eq(ir.all[14])
    expect(ir.find_all_with_description("Acrylique sur toile, mesurant environs 80/50cm.")).to eq([ir.all[30]])
    expect(ir.find_all_by_price(199)).to eq([ir.all[94]])
    expect(ir.find_all_by_price_in_range(593, 597)).to eq([ir.all[543], ir.all[563]])
    expect(ir.find_all_by_merchant_id(12334105)).to eq([ir.all[4], ir.all[665], ir.all[671]])
    expect(ir.all.last.name).to eq("Minty Green Knit Crochet Infinity Scarf")
    expect(ir.all.last.id).to eq(263567474)

    ir.create(
          {
          :id => 0,
          :name => "Stapler", 
          :description => "You can use this to staple things", 
          :unit_price => 7.00,
          :created_at => time_now,
          :updated_at => time_now,
          :merchant_id => 2
        }
        )

    expect(ir.all.last.name).to eq("Stapler")
    expect(ir.all.last.id).to eq(263567475)
  end
end