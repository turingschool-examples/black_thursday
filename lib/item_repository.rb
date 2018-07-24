require_relative 'item'
require_relative 'repository_module'

class ItemRepository
  include RepositoryModule

  def initialize(data_file)
    @repository = data_file.map {|item| Item.new(item)}
  end

  def find_all_with_description(description)
    @repository.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end
  #
  def find_all_by_price(price)
    @repository.find_all do |item|
      item.unit_price_to_dollars == price.to_f
    end
  end

  def find_all_by_price_in_range(range)
    @repository.find_all do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(id)
    @repository.find_all do |item|
      item.merchant_id == id
    end
  end

  def update(id, attributes)
      item = find_by_id(id)
      return if item.nil?
      item.name = attributes[:name]
      item.description = attributes[:description]
      item.unit_price = attributes[:unit_price]
      item.updated_at = Time.now
  end

  def inspect
  "#<#{self.class} #{@items.size} rows>"
  end
end


# def update(id, attributes)
#   item = find_by_id(id)
#   return if item.nil?
#   attributes.each do |key, value|
#     update_name_or_desc(item, key, value) if key == :name || key == :description
#     update_unit_price(item, value) if key == :unit_price
#   end
# end
#
# def update_name_or_desc(item, key, value)
#   item.attributes[key] = value
#   item.attributes[:updated_at] = Time.now
# end
#
# def update_unit_price(item, value)
#   item.attributes[:unit_price] = value * 100
#   item.attributes[:updated_at] = Time.now
# end
