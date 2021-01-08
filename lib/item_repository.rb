require 'pry'
require 'csv'
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
    @all.find{|item| item.id == id}
  end

  def find_by_name(name)
    @all.find{|item| item.name.downcase == name.downcase.strip}
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
    record = find_by_id(id)
    attributes.keys.each do |key|
      if attributes[:unit_price]
        record.unit_price = attributes[:unit_price]
      end

      if attributes[:name]
        record.name = attributes[:name]
      end

      if attributes[:description]
        record.description = attributes[:description]
      end
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
