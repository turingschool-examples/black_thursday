require_relative 'item'
require_relative 'repo_module'
class ItemRepository
  include RepoModule

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def initialize(items)
    @items = items
  end

  def all
    @items
  end

  # def find_by_id(id)
  #   @items.find {|item| item.id == id}
  # end

  # def find_by_name(name)
  #   @items.find {|item| item.name.upcase == name.upcase}
  # end

  def find_all_with_description(description)
    items_with_description = @items.find_all {|item| item.description.upcase == description.upcase}
  end

  def find_all_by_price(price)
    @items.find_all {|item| item.unit_price == price}
  end

  def find_all_by_price_in_range(range)
    price = range
    min = price.min
    max = price.max
    @items.find_all {|item|
      item.unit_price_to_dollars >= min && item.unit_price_to_dollars <= max}
  end

  def find_all_by_merchant_id(merch_id)
    @items.find_all {|item| item.merchant_id == merch_id}
  end

  def create(attributes)
    attributes[:id] = all_ids.max + 1
    new_item = Item.new(attributes)
    @items.push(new_item)
    new_item
  end

  def all_ids
    @items.map { |item| item.id}
  end

  def update(id, attributes)
    if all_ids.include?(id)
      updated_item = find_by_id(id)
      if attributes[:name] != nil
        updated_item.update_name(attributes[:name])
      end
      if attributes[:description] != nil
        updated_item.update_description(attributes[:description])
      end
      if attributes[:unit_price] != nil
        updated_item.update_unit_price(attributes[:unit_price])
      end
      updated_item.update_time
      updated_item
    end
  end

  def delete(id)
    @items.delete(find_by_id(id))
  end

end
