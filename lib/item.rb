# frozen_string_literals: true

require 'bigdecimal'
require 'time'
# ./lib/item.rb
class Item
  attr_reader :id,
              :created_at,
              :merchant_id
  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  @@highest_item_id = 0

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = BigDecimal.new(attributes[:unit_price], 4) / 100
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
    @merchant_id = attributes[:merchant_id].to_i
    highest_id_updater
  end

  def highest_id_updater
    @@highest_item_id = @id if @id > @@highest_item_id
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def self.create(attributes)
    item_id = @@highest_item_id += 1
    new(id: item_id,
        name: attributes[:name],
        description: attributes[:description],
        unit_price: attributes[:unit_price],
        created_at: attributes[:created_at].to_s,
        updated_at: attributes[:updated_at].to_s,
        merchant_id: attributes[:merchant_id])
  end
end
