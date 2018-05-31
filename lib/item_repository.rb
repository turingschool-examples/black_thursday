require_relative 'item'
require 'time'

class ItemRepository
  attr_reader :item_repo,
              :parent

  def initialize(loaded_file, parent)
    @item_repo = loaded_file.map { |item| Item.new(item, self)}
    @parent = parent
  end

  def all
    @item_repo
  end

  def find_by_id(id_num)
    all.find {|item| item.id == id_num}
  end

  def find_by_name(name)
    all.find {|item| item.name == name}
  end

  def find_all_with_description(description)
    all.find_all {|item| item.description.downcase == description.downcase}
  end

  def find_all_by_price(price)
    all.find_all {|item| item.unit_price.to_f == price.to_f}
  end

  def find_all_by_price_in_range(range)
    all.find_all {|item| range.include?(item.unit_price.to_f)}
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all {|item| item.merchant_id == merchant_id}
  end

  def create(attributes)
    highest = all.max_by {|item| item.id.to_i }
    item = {name: attributes[:name],
            description: attributes[:description],
            unit_price: (attributes[:unit_price]*100),
            id: (highest.id + 1),
            created_at: attributes[:created_at],
            updated_at: attributes[:updated_at],
            merchant_id: attributes[:merchant_id]}
    @item_repo.push(Item.new(item, self))
  end

  def update(id, attributes)
    item = find_by_id(id)
    return item if item == nil
    item.update_name(attributes[:name]) if !(attributes[:name].nil?)
    item.update_description(attributes[:description]) if !(attributes[:description].nil?)
    item.update_unit_price(attributes[:unit_price]) if !(attributes[:unit_price].nil?)
    item.new_update_time(Time.now.utc) if attributes.length > 0
  end

  def delete(id)
    item = find_by_id(id)
    return item if item == nil
    @item_repo.delete(item)
  end

  def inspect
   "#{self.class} #{@item_repo.size} rows"
  end
end
