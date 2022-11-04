require './spec/spec_helper'

RSpec.describe SalesAnalyst do
  describe 'iteration 1' do
    let (:item_1) {Item.new({:id => 1,
                     :name => "Shoes",
                     :description => "left shoe, right shoe",
                     :unit_price => BigDecimal(78.54,4),
                     :created_at => Time.now,
                     :updated_at => Time.now,
                     :merchant_id => 1})}
    let (:item_2) {Item.new({:id => 2,
                      :name => "Cool hat",
                      :description => "black top hat",
                      :unit_price => BigDecimal(22.24,4),
                      :created_at => Time.now,
                      :updated_at => Time.now,
                      :merchant_id => 2})}
    let (:item_3) {Item.new({:id => 3,
                      :name => "More Expensive Cool hat",
                      :description => "black top hat",
                      :unit_price => BigDecimal(32.44,4),
                      :created_at => Time.now,
                      :updated_at => Time.now,
                      :merchant_id => 2})}
    let (:items) {[item_1, item_2, item_3]}
    let (:item_repo) {ItemRepository.new(items)}
    let (:merchant_1) {Merchant.new({:id => 1,
                               :name => "Nike"})}
    let (:merchant_2) {Merchant.new({:id => 2,
                               :name => "Addidas"})}
    let (:merchants) {[merchant_1, merchant_2]}
    let (:merchant_repo) {MerchantRepository.new(merchants)}
    let (:sales_analyst) {SalesAnalyst.new(item_repo, merchant_repo)}
    
    it 'exists' do
      expect(sales_analyst).to be_a(SalesAnalyst)
    end
    
    it '#item_count can determine how many total items are available' do
      expect(sales_analyst.item_count).to eq(3)
    end
    
    it '#items_per_merchant() can determine how many products individual merchants sell' do
      expect(sales_analyst.items_per_merchant(1)).to eq(1)
      expect(sales_analyst.items_per_merchant(2)).to eq(2)
    end
    
    it '#merchant_count can count the total number of merchants' do
      expect(sales_analyst.merchant_count).to eq(2)
    end
    
    it '#average_items_per_merchant can determine how many products merchants sell on average' do
      expect(sales_analyst.average_items_per_merchant).to eq(1.5)
    end
    
    it '#average_items_per_merchant_standard_deviation can determine standard deviation on average items per merchant' do
      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(0.71)
    end
    
    xit '#merchants_with_high_item_count can determine which merchants sell the highest number of items' do
      expect(sales_analyst.merchants_with_high_item_count).to eq([])
    end
    
    it '#average_average_price_per_merchant can determine the average price of an item across all merchants' do
      expect(sales_analyst.average_item_price_for_merchant(1)).to eq(0.7854e2)
      #this test isn't passing here, but the spec_harness does and I'm not sure why
    end
    
    it '#average_average_price_per_merchant can determine the average price of an item across all merchants' do
      expect(sales_analyst.average_average_price_per_merchant).to eq(0.5294e2)
    end
    
    xit '#golden_items can determine which items are 2 standard deviations above the avg item price' do
      expect(sales_analyst.golden_items).to eq([])
    end
    
    # xit '' do
    # end
    # 
    # xit '' do
    # end
    
  end
end