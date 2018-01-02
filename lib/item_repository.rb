require 'csv'
require './lib/item'

class ItemRepository

  attr_reader :items_csv,
              :items

  def initialize
    @items_csv = CSV.open './data/items.csv', headers: true, header_converters: :symbol
    @items = []
    items_csv.each do |row|
      id          = row[:id]
      name        = row[:name]
      unit_price  = row[:unit_price]
      created_at  = row[:created_at]
      updated_at  = row[:updated_at]
      description = row[:description]
      merchant_id = row[:merchant_id]
      @items << Item.new({
        name: name,
        id: id,
        description: description,
        unit_price: unit_price,
        created_at: created_at,
        updated_at: updated_at,
        merchant_id: merchant_id
        })
    end
  end


  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      item.id if item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name if item.name == name
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item if item.description.downcase.include?(description.downcase)
    end
  end

end
