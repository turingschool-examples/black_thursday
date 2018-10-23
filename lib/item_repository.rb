require './lib/repository'
require './lib/item'

class ItemRepository < Repository
  def create(args)
    super(Item.new(args))
  end

  def find_all_with_description(description)
    @instances.find_all {|item| item.description == description}
  end

  def find_all_by_price(price)
    @instances.find_all {|item| item.unit_price == price}
  end

  def find_all_by_price_range(start_number, end_number)
    @instances.find_all do |item|
      item.unit_price >= start_number || item.unit_price <= end_number
    end
  end
end
