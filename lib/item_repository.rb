require './lib/item'

class ItemRepository
  attr_reader :inventory

  def initialize(parent)
    @se = parent
  end

  def items(inventory)
    inventory.map do |column|
      item = Item.new(column, self)
     end
  end

  def all
    @inventory.empty? ?  nil : @inventory
  end

  def find_by_id(find_id)
    @inventory.find {|item| item.id == find_id }
  end

  def find_by_name(find_name)
    @inventory.find {|item| item.name.downcase == find_name.downcase }
  end

  def find_all_with_description(find_description)
    @inventory.find_all do |item|
      item.description.downcase == find_description.downcase
    end
  end

  def find_all_by_price(price)
    @inventory.find_all {|item| item.unit_price == price}

  end

  def find_all_by_price_in_range(range)
    @inventory.find_all {|item| range.include?(item.unit_price)}
  end

  def find_all_by_merchant_id(merchant_id)
    @inventory.find_all {|item| item.merchant_id == merchant_id}
  end

end
