require 'csv'


#CSV::Converters[:hashify] = ->(value) { stuff = value }

class ItemRepository
attr_reader :all


  @@filename = './data/items.csv'
  def initialize(fill_items)
    @all = fill_items
  end

  # def fill_items
  #   all_items = CSV.parse(File.read(@@filename))
  #   categories = all_items.shift
  #   grouped_items = []
  #
  #   all_items.each do |item|
  #     individual_item = {}
  #     categories.zip(item) do |category, attribute|
  #
  #       individual_item[category.to_sym] = attribute
  #     end
  #     grouped_items << Item.new(individual_item)
  #   end
  #   grouped_items
  # end

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
    new_item = Item.new(attributes)
      if new_item.id == nil
        new_item.id = current_item.id
      end
      if new_item.name == nil
        new_item.name = current_item.name
      end
      if new_item.description == nil
        new_item.description = current_item.description
      end
      if new_item.unit_price == nil
        new_item.unit_price = current_item.unit_price
      end
      if new_item.created_at == nil
        new_item.created_at = current_item.created_at
      end
      if new_item.updated_at == nil
        new_item.updated_at = current_item.updated_at
      end
      if new_item.merchant_id == nil
        new_item.merchant_id = current_item.merchant_id
      end
    all[all.find_index(current_item)] = new_item
  end

  def delete(id)
    item_to_delete = find_by_id(id)
    position_of_item = all.find_index(item_to_delete)
    all.delete_at(position_of_item)
  end
end

# attributes.key.to_sym
