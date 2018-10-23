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
end
