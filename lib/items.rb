require './lib/item_repository'

class Item
  attr_reader  :item

  def initialize(line)
    @line     = line
    @item = { 
      "id" => id,
      "name" => name,
      "description" => description,
      "unit_price"  => unit_price,
      "created_at"  => created_at,
      "updated_at"  => updated_at,
      "merchant_id" => merchant_id
      }
  end

  def id
    @line[:id]
  end

  def name
    @line[:name]
  end

  def description
    @line[:description]
  end

  def unit_price
    @line[:unit_price]
  end

  def created_at
    @line[:created_at]
  end

  def updated_at
    @line[:updated_at]
  end

  def merchant_id
    @line[:merchant_id]
  end

end

puts ItemRepository.new.find_all_by_price_in_range(3700..3800)
