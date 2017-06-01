require_relative './item'
require 'bigdecimal'

class ItemRepository

  attr_reader :all

  def initialize
    @all = []
  end

  def populate_items(line)
      id = line[0]
      merchant_id = line[4]
      name = line[1]
      description = line[2]
      unit_price = BigDecimal.new(line[3].to_i, 4)
      created_at = line[5]
      updated_at = line[6]
    self.all << Item.new({ :id => id,
                           :merchant_id => merchant_id,
                           :name => name,
                           :description => description,
                           :unit_price => unit_price,
                           :created_at => created_at,
                           :updated_at => updated_at })
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      if item.name.downcase == name.downcase
        return item
      end
      nil
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase == description.downcase
    end
  end

  def find_all_by_price(unit_price)
    result = []
    @all.find_all do |item|
      if item.unit_price == unit_price
        result << item
      end
    end
    result
  end

  def find_all_by_price_in_range(range)
    result = []
    @all.each do |item|
      if range.include? item.unit_price
        result << item
      end
    end
    result
  end

  def find_all_by_merchant_id(merchant_id)
    result = []
    @all.find_all do |item|
      if item.merchant_id == merchant_id
        result << item
      end
    end
    result
  end

end
