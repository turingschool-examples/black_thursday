require './lib/item_repository'
require './lib/item'

RSpec.describe ItemRepository do
  before :each do

      @item = Item.new({
          :id          => 1,
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal(10.99,4),
          :created_at  => Time.now,
          :updated_at  => Time.now,
          :merchant_id => 2
          })
        end

  it "exists and has attributes" do

    expect(@item).to be_instance_of ItemRepository
  end
end
