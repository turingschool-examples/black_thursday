require 'csv'
require './lib/sales_engine'
require './lib/item'

class ItemRepository
  attr_reader :all

  def initialize(item_path)
    @all = (
      item_objects = []
      CSV.foreach(item_path, headers: true, header_converters: :symbol) do |row|
        item_objects << Item.new(row)
      end
    item_objects)

  end

  def find_by_id(id)
    if (@all.any? do |item|
      item.id == id
    end) == true
      @all.find do |item|
        item.id == id
      end
    else
      nil
    end
  end

  def find_by_name(name)
    if (@all.any? do |item|
      item.name.upcase == name.upcase
    end) == true
      @all.find do |item|
        item.name.upcase == name.upcase
      end
    else
      nil
    end
  end

  def find_all_with_description(description)
    if (@all.any? do |item|
      item.description == description
    end) == true
      @all.find_all do |item|
        item.description == description
      end
    else
      []
    end
  end

  def find_all_by_price(unit_price)
    # @unit_price.to_f.to_s

    if (@all.any? do |item|
      item.unit_price == unit_price
    end) == true
      @all.find_all do |item|
        item.unit_price == unit_price
      end
    else
      []
    end
  end

  def find_all_by_price_in_range(range)
    in_range = []
    @all.find_all do |item|
      if item.find_all_by_price.include?(range)
    end
      # item.unit_price do |price|
      # end
    # if item.find_all_by_price.include?(range)

      #  @all.find_all do |item|
      #   item.unit_price do |price|
      #     if price.include?(range)
      #     end
    end
      in_range << item

      in_range
  end

  def find_all_by_merchant_id(merchant_id)
    if (@all.any? do |item|
      item.merchant_id == merchant_id
    end) == true
      @all.find_all do |item|
      item.merchant_id == merchant_id
      end
    else
      []
    end
  end

  def create(attributes)
    new_item = Item.new(attributes)
    @all << new_item
  end

  def update(id, new_name)
    if find_by_id(id) != nil
      (find_by_id(id).name.clear.gsub!("", new_name))
    end
  end

  def delete(id)
    if find_by_id(id) != nil
      @all.delete(@all.find do |item|
        item.id == id
      end)
    end
  end
end
