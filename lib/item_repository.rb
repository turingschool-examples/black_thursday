require 'csv'
require_relative '../lib/item'

class ItemRepository
  attr_reader :all

  def initialize(path)
    @path = path
    @all = to_array
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def to_array
    items = []

    CSV.foreach(@path, headers: true, header_converters: :symbol) do |row|
      headers = row.headers
      items << row.to_h
    end
    items.map do | item |
      Item.new(item)
    end
  end

  def find_by_id(id)
    all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    all.find do | item |
      item.name.downcase == name.downcase
    end
  end


  def find_all_with_description(description)
    description.upcase!

    all.find_all do | item |
      item.description.upcase.include?(description)
    end
  end

  def find_all_by_price(price)
    all.select do | item |
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    all.select do | item |
      range.first <= item.unit_price && range.last >= item.unit_price
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.select do | item |
      merchant_id == item.merchant_id
    end
  end

  def find_highest_id
    max_item = all.max_by do | item |
      item.id
    end
    max_item.id
  end

  def create(attributes)
    id = find_highest_id + 1
    # current_time = Time.now.utc
    info = {
      id: id.to_s,
      name: attributes[:name],
      description: attributes[:description],
      unit_price: attributes[:unit_price].to_s,
      merchant_id: attributes[:merchant_id].to_s,
      created_at: attributes[:created_at].to_s,
      updated_at: attributes[:updated_at].to_s
    }
    @all << Item.new(info)
  end

  def update(id, attributes)
    if attributes[:name] != nil
      find_by_id(id).change_name(attributes[:name])
    elsif attributes[:description] != nil
      find_by_id(id).change_description(attributes[:description])
    elsif attributes[:unit_price] != nil
      find_by_id(id).change_unit_price(attributes[:unit_price])
    end
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end
end
