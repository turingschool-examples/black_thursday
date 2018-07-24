require_relative 'item'
require_relative 'repository_module'

class ItemRepository
  include RepositoryModule

  def initialize(data_file)
    @repository = data_file.map {|item| Item.new(item)}
  end

  def find_all_with_description(description)
    @repository.find_all do |item|
      item.description == description
    end
  end
  #
  def update(id, attributes)
    item = find_by_id(id)
    return if item.nil?
    attributes.each do |key, value|
      update_name_or_desc(item, key, value) if key == :name || key == :description
      update_unit_price(item, value) if key == :unit_price
    end
  end

  def update_name_or_desc(item, key, value)
    item.attributes[key] = value
    item.attributes[:updated_at] = Time.now + 1
  end

  def update_unit_price(item, value)
    item.attributes[:unit_price] = value * 100
    item.attributes[:updated_at] = Time.now + 1
  end

   # *update(id, attributes) - update the Item instance with the corresponding id with the provided attributes. Only the item’s name, desription, and unit_price attributes can be updated. This method will also change the items updated_at attribute to the current time.
end
