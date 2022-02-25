# item_repository
require 'pry'
class ItemRepository
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find { |item| item.id == id }
  end

  def find_by_name(name)
    @items.find { |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(description)
    @items.find_all { |item| item.description.downcase == description.downcase }
  end

  def find_all_by_price(price)
    @items.find_all { |item| item.unit_price.to_i == price }
  end

  def find_all_by_price_in_range(range)
    @items.find_all { |item| item.unit_price.to_i >= range.first && item.unit_price.to_i <= range.last }
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all { |item| item.merchant_id == merchant_id }
  end

  def create(attributes)
    @items.sort_by { |item| item.id }
    last_id = @items.last.id
    attributes[:id] = (last_id += 1)
    @items << Item.new(attributes)
  end

  def update(id, attributes)
    item = find_by_id(id)
    attributes.each do |key, v|
      item = {key v}
      # binding.pry
    end
    item
    # case attributes
    # when attributres[:name] == item.name
    #   attributes[:name] = item.name
    # when [:description]

    #   item.attributes.each { | k , v |
    #     if v = :name
    #       item.name = attributes[:name]

    # }

    # name, description, unit_price only need to be updated
  end
end
