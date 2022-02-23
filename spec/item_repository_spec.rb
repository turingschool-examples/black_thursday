require 'Rspec'
require './lib/item_repository'
require 'pry'
require 'BigDecimal'

RSpec.describe ItemRepository do

  before (:each) do
    item1 = Hash.new
    item1[:id] = 1
    item1[:name] = "pencil"
    item1[:description] = "You can use it to write"
    item1[:unit_price] = BigDecimal(10.99,4)
    item1[:created_at] = Time.now
    item1[:updated_at] = Time.now
    item1[:merchant_id] = 2

    item2 = Hash.new
    item2[:id] = 2
    item2[:name] = "phone case"
    item2[:description] = "Protects your phone"
    item2[:unit_price] = BigDecimal(20.99,4)
    item2[:created_at] = Time.now
    item2[:updated_at] = Time.now
    item2[:merchant_id] = 3

    item3 = Hash.new
    item3[:id] = 3
    item3[:name] = "phone diaper"
    item3[:description] = "A diaper for your phone"
    item3[:unit_price] = BigDecimal(2.99,4)
    item3[:created_at] = Time.now
    item3[:updated_at] = Time.now
    item3[:merchant_id] = 3


    @ir = ItemRepository.new([@item1], [@item2], [@item3])
  end

  it 'can find all items that include fragment in name' do
    expect(@ir.find_all_by_name("phone")).to eq([@item2, @item3])
  end

end
