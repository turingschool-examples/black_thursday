# frozen_string_literal: true

require './lib/item'

# Item repository class
class ItemRepository
  def initialize
    @items = {}
  end

  def create(params)
    params[:id] = @items.max[0] + 1 if params[:id].nil?

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
    found_items.keep_if do |thing|
      thing.is_a?(Item)
    end
  end
end
