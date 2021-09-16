require 'csv'


#CSV::Converters[:hashify] = ->(value) { stuff = value }

class ItemRepository
  attr_reader :all

  def initialize(file)
    @all = fill_items(file)
  end

  def fill_items(file)
    all_items = CSV.parse(File.read(file))
    categories = all_items.shift
    all_items.map do |item|
      individual_item = {}
      categories.zip(item) do |category, attribute|
        individual_item[category.to_sym] = attribute
      end
      Item.new(individual_item)
    end
  end

  def find_by_id(id)
    all.find do |item|
      item.id.to_i == id.to_i
    end
  end

  def find_by_name(name)
    all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end.uniq
  end

  def find_all_by_price(price)
    all.find_all do |item|
      item.unit_price.to_i == price.to_i
    end
  end

  def find_all_by_price_in_range(range)
    all.map do |item|
      if item.unit_price.to_i >= range.first && item.unit_price.to_i <= range.last
        item
      else
      end
    end.compact
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |item|
      item.merchant_id.to_i == merchant_id.to_i
    end
  end

  def create(attributes)
    all << Item.new(attributes)
  end

  def update(id, attributes)
    current_item = find_by_id(id)
    all[all.find_index(current_item)] = current_item.update_item(attributes)
  end

  def delete(id)
    item_to_delete = find_by_id(id)
    position_of_item = all.find_index(item_to_delete)
    all.delete_at(position_of_item)
  end
end

# attributes.key.to_sym
