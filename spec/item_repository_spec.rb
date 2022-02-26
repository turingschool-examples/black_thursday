require 'Rspec'
require './lib/item_repository'
require 'pry'
require 'BigDecimal'

RSpec.describe ItemRepository do

  before (:each) do
    @item1 = double('item1')
    @item2 = double('item2')
    @item3 = double('item3')

    allow(@item1).to receive(:id){1}
    allow(@item1).to receive(:name){"pencil"}
    allow(@item1).to receive(:description){"You can use it to write"}
    allow(@item1).to receive(:unit_price){BigDecimal(10.99,4)}
    allow(@item1).to receive(:created_at){Time.now}
    allow(@item1).to receive(:updated_at){Time.now}
    allow(@item1).to receive(:merchant_id){1}


    allow(@item2).to receive(:id){2}
    allow(@item2).to receive(:name){"phone case"}
    allow(@item2).to receive(:description){"Protects your phone"}
    allow(@item2).to receive(:unit_price){BigDecimal(20.99,4)}
    allow(@item2).to receive(:created_at){Time.now}
    allow(@item2).to receive(:updated_at){Time.now}
    allow(@item2).to receive(:merchant_id){2}

    allow(@item3).to receive(:id){3}
    allow(@item3).to receive(:name){"phone diaper"}
    allow(@item3).to receive(:description){"A diaper for your phone"}
    allow(@item3).to receive(:unit_price){BigDecimal(10.99,4)}
    allow(@item3).to receive(:created_at){Time.now}
    allow(@item3).to receive(:updated_at){Time.now}
    allow(@item3).to receive(:merchant_id){2}

    @ir = ItemRepository.new([@item1, @item2, @item3])
    # binding.pry
    # @item1 = Hash.new
    # @item1[:id] = 1
    # @item1[:name] = "pencil"
    # @item1[:description] = "You can use it to write"
    # @item1[:unit_price] = BigDecimal(10.99,4)
    # @item1[:created_at] = Time.now
    # @item1[:updated_at] = Time.now
    # @item1[:merchant_id] = 2
    #
    # @item2 = Hash.new
    # @item2[:id] = 2
    # @item2[:name] = "phone case"
    # @item2[:description] = "Protects your phone"
    # @item2[:unit_price] = BigDecimal(20.99,4)
    # @item2[:created_at] = Time.now
    # @item2[:updated_at] = Time.now
    # @item2[:merchant_id] = 3
    #
    # @item3 = Hash.new
    # @item3[:id] = 3
    # @item3[:name] = "phone diaper"
    # @item3[:description] = "A diaper for your phone"
    # @item3[:unit_price] = BigDecimal(2.99,4)
    # @item3[:created_at] = Time.now
    # @item3[:updated_at] = Time.now
    # @item3[:merchant_id] = 3
    #
    #
    # @ir = ItemRepository.new([@item1, @item2, @item3])
  end

  it 'can find all items that include fragment in description' do
    expect(@ir.find_all_by_description("phone")).to eq([@item2, @item3])
  end

  it 'can find all items that have exact price' do
    expect(@ir.find_all_by_price(10.99)).to eq([@item1, @item3])
  end

  it 'can find all items within a price range' do
    expect(@ir.find_all_by_price_in_range(0..100)).to eq([@item1, @item2, @item3])
  end

  it 'can find all items that have exact merchant id' do
    expect(@ir.find_all_by_merchant_id(2)).to eq([@item2, @item3])
  end

  # it 'updates' do
  #   @ir.update(1,{name: "pen", description: "can't erase me", unit_price:1.99})
  #   expect(@ir.all[0].name).to eq("pen")
  # end

end
