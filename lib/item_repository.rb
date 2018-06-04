require_relative 'repository'
require_relative 'item'
require 'time'

class ItemRepository
  include Repository

  def initialize(loaded_file)
    @repository = loaded_file.map { |item| Item.new(item) }
  end

  def find_by_name(name)
    all.find { |item| item.name == name }
  end

  def find_all_with_description(description)
    all.find_all { |item| item.description.casecmp(description).zero? }
  end

  def find_all_by_price(price)
    all.find_all { |item| item.unit_price.to_f == price.to_f }
  end

  def find_all_by_price_in_range(range)
    all.find_all { |item| range.include?(item.unit_price.to_f) }
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all { |item| item.merchant_id == merchant_id }
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @repository.push(Item.new(attributes))
  end

  def update(id, attributes)
    item = find_by_id(id)
    return item if item.nil?
    item.update_name(attributes[:name]) unless attributes[:name].nil?
    item.update_description(attributes[:description]) unless attributes[:description].nil?
    item.update_unit_price(attributes[:unit_price]) unless attributes[:unit_price].nil?
    item.new_update_time(Time.now.utc) if attributes.length.positive?
  end
end
