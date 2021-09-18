require './lib/item'
require './lib/item_repository'

RSpec.describe do
  it 'exists' do
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"
                            })
    ir = se.items

    expect(ir).to be_an_instance_of(ItemRepository)
  end
end
