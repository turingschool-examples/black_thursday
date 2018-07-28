require_relative 'item'

class ItemRepository
  def initialize(item_data)
    @item_rows ||= build_item(item_data)
    @repo = @item_rows
  end

  def build_item(item_data)
    item_data.map do |item|
      Item.new(item)
    end
  end

  def all
    @repo
  end

  def find_by_id(id)
    @repo.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @repo.find do |item|
      item.name.casecmp(name).zero?
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

  def find_all_by_merchant_id(merchant_id)
    @repo.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_highest_id
    @repo.max_by do |item|
      item.id
    end
  end

  def create_id
    find_highest_id.id + 1
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

  def delete(id)
    item = @repo.find_index do |item|
      item.id == id
    end
    return if item.nil?
    @repo.delete_at(item)
  end

  def inspect
    "#<#{self.class} #{@repo.size} rows>"
  end
end
