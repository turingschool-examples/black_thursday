# require_relative 'sales_engine'
require_relative 'item'

class ItemRepository
  # Responsible for holding and searching Item instances.
  attr_reader :items

  def initialize(items)
    @items = items
    @repository = []
    create_all_items
  end

  def create_all_items
    @items.each do |item|
      @repository << Item.new(item)
    end
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |item|
      id == item.id
    end
  end

  def find_by_name(name)
    @repository.find do |item|
      name == item.name
    end
  end

  def find_all_by_name(name)
    @repository.find_all do |item|
      item.name.include?(name)
    end
  end

  def find_all_with_description(description)
    @repository.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @repository.find_all do |item|
      merchant_id == item.merchant_id
    end
  end

  def find_all_by_price(price)
    @repository.find_all do |item|
      price == item.unit_price
    end
  end

  def find_all_by_price_in_range(range)
    @repository.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def update(id, attributes)
    item = find_by_id(id)
    item.name = attributes[:name]
    item.description = attributes[:description]
    item.unit_price = attributes[:unit_price]
    item.updated_at = Time.now.to_s
  end

  def create(attributes)
    highest_id = @repository.max_by { |item| item.id }
    attributes[:id] = highest_id.id + 1
    attributes[:created_at] = attributes[:created_at].to_s
    attributes[:updated_at] = attributes[:updated_at].to_s
    @repository << Item.new(attributes)
  end

  def delete(id)
    item = find_by_id(id)
    @repository.delete(item)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
