require './lib/repository'
require './lib/item'

class ItemRepository < Repository
  def create(args)
    super(Item.new(args))
  end
end
