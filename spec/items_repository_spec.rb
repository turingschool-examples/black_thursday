require 'rspec'
require './lib/items_repository'

describe ItemsRepository do
  before(:each) do
    @ir = ItemsRepository.new("./data/items.csv")
  end

  it "exists" do
    expect(@ir).to be_an_instance_of(ItemsRepository)
  end

  it 'lists all items' do
    expect(@ir.all).to eq(@ir.repository)
  end
end
