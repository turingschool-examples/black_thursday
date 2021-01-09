require 'csv'
require 'bigdecimal'
require 'time'
require_relative './item'

class ItemRepository
  attr_reader :all,
              :engine

  def initialize(items_path, engine)
    @all = []
    @engine = engine

    CSV.foreach(items_path, headers: true, header_converters: :symbol) do |row|
      @all << convert_to_item(row)
    end
  end

  def convert_to_item(row)
    row = Item.new({id: row[:id],
                    name: row[:name],
                    description: row[:description],
                    unit_price: row[:unit_price],
                    created_at: row[:created_at],
                    updated_at: row[:updated_at],
                    merchant_id: row[:merchant_id]
                   }, self)
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.downcase == name.downcase.strip
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase.include?(description.downcase.strip)
    end
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
    attributes[:id] = new_highest_id
    @all << Item.new(attributes, self)
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      update_item = all.find { |item| item.id == id }
      update_item.name = attributes[:name] if attributes[:name] != nil
      update_item.description = attributes[:description] if attributes[:description] != nil
      update_item.unit_price = BigDecimal.new(attributes[:unit_price].to_i)/100 if attributes[:unit_price] != nil
      update_item.updated_at = Time.now
    end
  end

  def delete(id)
    remove = find_by_id(id)
    @all.delete(remove)
  end

  def new_highest_id
    all.max_by do |instance|
      instance.id
    end.id + 1
  end
end
