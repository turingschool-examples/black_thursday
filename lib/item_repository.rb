require_relative '../lib/item'
require 'CSV'


class ItemRepository
  attr_reader :filename, :items

  def initialize(filename)
    @filename = filename
    @items = self.all
  end

  def rows
    rows = CSV.read(@filename, headers: true, header_converters: :symbol)
  end


  def all
    result = rows.map {|row| Item.new(row)}
  end

  def find_by_id(id)
    @items.find do |item|
      if item.id == id
        item
      end
    end
  end

  def find_by_name(name)
    @items.find do |item|
      if item.name == name
        item
      end
    end
  end

  def find_all_with_description(description)
    words = description.downcase
    @items.find_all do |item|
      if item.description.include?(words)
        item
      end
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      if item.unit_price == price
        item
      end
    end
  end

  def find_all_by_price_in_range(range)

    @items.find_all do |item|
      if range.include?(item.unit_price.to_i)
        item
      end
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      if item.merchant_id == merchant_id
        item
      end
    end
  end

  def current_highest_id
    sorted = @items.sort_by {|item| item.id}

    highest_id = sorted[-1].id
    highest_id.to_i

  end

  def create(attributes)

    new_id = current_highest_id + 1
    new_id = new_id.to_s
    attributes[:id] = new_id
    new_item = Item.new(attributes)

    @items << new_item
    return new_item



  end




end
