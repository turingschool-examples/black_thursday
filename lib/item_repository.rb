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

  def create_new_id_number
    max_id = @repository.max_by(&:id).id
    new_id = max_id + 1
  end

  def create(attributes)
    new_id = create_new_id_number
    attributes[:id] = new_id
     @repository << Item.new(attributes)
  end

  def inspect
  "#<#{self.class} #{@items.size} rows>"
  end
end
