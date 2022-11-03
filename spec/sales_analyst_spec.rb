require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

RSpec.describe SalesAnalyst do 
  let(:se) {SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })}

  it 'exists' do 
    sales_analyst = SalesAnalyst.new(ItemRepository.new, MerchantRepository.new) 

    expect(sales_analyst).to be_a(SalesAnalyst)
  end

  describe '#analyst' do 
    it 'creates an instance of SalesAnalyst' do 
      expect(se.analyst).to be_a(SalesAnalyst)
    end
  end

  describe '#average_items_per_merchant' do 
    it 'returns the an average amount of items a merchant sells' do 
      sales_analyst = se.analyst

      expect(sales_analyst.average_items_per_merchant).to eq(2.88)
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do 
    it 'returns the standard deviation of the average items per merchant' do 
      sales_analyst = se.analyst

      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    end
  end

end