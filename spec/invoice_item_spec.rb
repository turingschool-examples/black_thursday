require "Rspec"
require "bigdecimal"
require_relative "../lib/item"

describe Item do
  before :each do
    @i = Item.new({
              id: '1',
         item_id: '263519844',
      invoice_id: '1',
        quantity: '5',
      unit_price: '13635',
      created_at: '2016-01-11 09:34:06 UTC',
      updated_at: '2017-06-04 21:35:10 UTC'
    })
  end

  it 'is an item' do
    expect(@i).to be_a Item
  end
