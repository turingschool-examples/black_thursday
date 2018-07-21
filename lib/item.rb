require 'bigdecimal'
class Item

  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at,
              :merchant_id
  @@highest_item_id = 0

  def initialize(hash)
    @id = hash[:id].to_i
    @name = hash[:name]
    @description = hash[:description]
    @unit_price = BigDecimal.new(hash[:unit_price])
    @created_at = Time.new(hash[:created_at])
    @updated_at = Time.new(hash[:updated_at])
    @merchant_id = hash[:merchant_id].to_i
    if @id > @@highest_item_id
      @@highest_item_id = @id
    end
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def self.create(attributes)
    item_id = @@highest_item_id += 1
    Item.new({id: item_id,
              name: attributes[:name],
              description: attributes[:description],
              unit_price: attributes[:unit_price],
              created_at: attributes[:created_at],
              updated_at: attributes[:updated_at],
              merchant_id: attributes[:merchant_id]
            })
  end

end
