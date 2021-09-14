require './lib/sales_engine'

RSpec.describe SalesEngine do
  context 'Iteration 0' do
    it 'exists' do
      se = SalesEngine.new
      expect(se).to be_an_instance_of(SalesEngine)
    end

    it 'can access items' do
      se = SalesEngine.new
      ir   = ItemRepository.new("./data/items.csv")
      expect(ir.find_by_name("Disney scrabble frames")).to be_an_instance_of(Item)
    end

    # it 'can access merchants' do
    #   se = SalesEngine.new
    #   mr   = MerchantRepository.new("./data/merchants.csv")
    #   expect(mr.find_by_name("jejum")).to be_an_instance_of(Merchant)
    # end
  end
end
