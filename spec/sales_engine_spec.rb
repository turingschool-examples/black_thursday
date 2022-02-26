require './lib/sales_engine'

RSpec.describe SalesEngine do
  it 'can pull items and merchants from csv' do
    se = SalesEngine.from_csv({
                                items: './data/items.csv',
                                merchants: './data/merchants.csv'
                              })

    expect(se).to be_a(SalesEngine)
    expect(se.item_repo).to be_a(ItemRepository)
    expect(se.merch_repo).to be_a(MerchantRepository)
    expect(se.item_repo.items.length).to eq(1367)
    expect(se.merch_repo.merchants.count).to eq(475)
  end
end
