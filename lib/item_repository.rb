require_relative '../spec/spec_helper'
require 'time'

class ItemRepository
  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
  attr_reader :all,
              :engine

  def initialize(path, engine)
    @all = []
    create_items(path)
    @engine = engine
  end

  def create_items(path)
    items = CSV.foreach(path, headers: true, header_converters: :symbol) do |item_data|
      data_hash = {
        id:           item_data[:id],
        name:         item_data[:name],
        description:  item_data[:description],
        #bigdecimal goes in front of item data with a parens after
        unit_price:   item_data[:unit_price],
        created_at:   Time.parse(item_data[:created_at]),
        updated_at:   Time.parse(item_data[:updated_at]),
        merchant_id:  item_data[:merchant_id].to_i
      }
      @all << Item.new(data_hash, self)
    end
  end

  def find_by_id(id)
    return nil unless
    @all.find_all do |item|
      if item.id == id
        return item
      end
    end
  end

  def find_by_name(name)
    return nil unless
    @all.find_all do |item|
      if item.name.downcase == name.downcase
        return item
      end
    end
  end

  def find_all_with_description(description)
    found_items = @all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
    found_items
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    highest_id = @all.max_by do |item|
      item.id
    end
    new_item = Item.new(attributes, self)
    new_item.new_id(highest_id.id + 1)
    @all << new_item
  end

  def update(id, attributes)
    found_item = @all.find do |item|
      item.id == id
    end
    # attributes.each do |key, value| #{this is a hash} lol jk
    #   if found_item.item_data.has_key?(key) == true
    #     item.item_hash[key] = value
    #       puts true
    #   end
    # end
  end

  def delete(id, attributes)
    to_delete = @all.find do |item|
      item.id == id
    end
    @all.delete(to_delete)
  end

  def item_count_per_merchant
    items_per_merchant = {}
    @all_items.each do |item|
      items_per_merchant[item.merchant_id] = find_all_by_merchant_id(merchant_id).length
    end
    items_per_merchant
  end
end
