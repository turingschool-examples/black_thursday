require_relative 'item'
require_relative 'repo_methods'

class ItemRepository
  include RepoMethods

  def initialize(item_data)
    @item_rows ||= build_item(item_data)
    @repo = @item_rows
  end

  def build_item(item_data)
    item_data.map do |item|
      Item.new(item)
    end
  end

  def find_all_with_description(description)
    @repo.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @repo.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @repo.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def create(attributes)
    id = create_id
    attributes[:id] = id
    item = Item.new(attributes)
    @repo << item
  end

  def update(id, attributes)
    item = find_by_id(id)
    return if item.nil?
    item.name = attributes[:name] || item.name # if name DNE, will return nil, making it falsey -> rt side
    item.description = attributes[:description] || item.description
    item.unit_price = attributes[:unit_price] || item.unit_price
    item.updated_at = Time.now
  end
end
