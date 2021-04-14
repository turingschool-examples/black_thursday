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
  
      i = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2})

      expect(i.id).to eq(1)
      expect(i.name).to eq("Pencil")
      expect(i.description).to eq("You can use it to write things")
      expect(i.unit_price).to be_an_instance_of(BigDecimal)
      expect(i.created_at).to be_an_instance_of(Time)
      expect(i.updated_at).to be_an_instance_of(Time)
    end
  end

  describe '#methods' do
    it '#populates information' do
      ir = ItemRepo.new
      i = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2})
    require 'pry'; binding.pry
      expect(ir.populate_information).to be_an_instance_of(Hash)
    end
  end
end