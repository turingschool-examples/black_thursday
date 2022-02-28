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



end
