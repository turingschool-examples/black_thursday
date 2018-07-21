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

  def find_by_id(id)
    @items.fetch(id)
  end

  def find_by_name(name)
    @items.find do |_, item|
      item.name.downcase == name.downcase
    end.last
  end

  def find_all_with_description(input)
    found_items = @items.find_all do |_, item|
      item.description.downcase.include?(input.downcase)
    end.flatten
    found_items.delete_if do |thing|
      !thing.is_a?(Item)
    end
  end

end
