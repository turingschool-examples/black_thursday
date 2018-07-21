require './lib/item'

class ItemRepository

  def initialize
    @items = {}
  end

  def create(params)
    if params[:id].nil?
      params[:id] = @items.max[0] + 1
    end
    Item.new(params).tap do |item|
      @items[params[:id]] = item
    end
  end

  def all
    @items
  end

end
