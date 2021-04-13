require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require 'BigDecimal'

RSpec.describe Item do

  describe '#initialize' do
    item = Item.new({
                      :id          => 1,
                      :name        => "Pencil",
                      :description => "You can use it to write things",
                      :unit_price  => 10.88, # BigDecimal.new(10.99,4),
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                      :merchant_id => 2
                    })

    it 'exists' do
      expect(item).to be_instance_of(Item)
    end
  end

end
