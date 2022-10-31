require './lib/item'

RSpec.describe do
  
  it 'exists' do
    item = Item.new

    expect(item).to be_a(Item)
  end
end