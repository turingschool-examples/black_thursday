require 'CSV'
require 'RSpec'
require './lib/sales_engine'
require './lib/item'
require './lib/item_repository'
require 'bigdecimal'
# require './data/merchants.csv'

RSpec.describe ItemRepo do
  describe 'instantiation' do

    it '::new' do
      ir = ItemRepo.new

    expect(ir).to be_an_instance_of(ItemRepo)
    end

    it 'has attributes' do
      ir = ItemRepo.new
  
      expect(ir.items).to eq ([])
    end
  end

  describe '#methods' do
    it '#populates information' do
      ir = ItemRepo.new

      expect(ir.populate_information).to be_an_instance_of(Hash)
    end

    it '#all' do
      ir = ItemRepo.new

      expect(ir.all).to be_an_instance_of(Array)
    end

    it '#find by id' do
      ir = ItemRepo.new
      i = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2
                  })
      id = "263395237"
      ir.items << i 

      expect(ir.find_by_id(id)).to eq(i)
    end
  end
end