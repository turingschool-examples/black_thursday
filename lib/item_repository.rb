require 'csv'
require_relative './item'

class ItemRepository
  attr_accessor :items_array
  attr_reader :contents

  def initialize(path)
    @items_path = path
    @items_array = []
  end

  def pull_csv
    @contents = CSV.open @items_path, headers: true, header_converters: :symbol
  end

  def parse_csv
    @contents.each do |row|
      name        = row[:name]
      id          = row[:id]
      description = row[:description]
      unit_price  = row[:unit_price]
      created_at  = row[:created_at]
      updated_at  = row[:updated_at]
      merchant_id = row[:merchant_id]

      items_array << Item.new({
        :name        => name,
        :id          => id,
        :description => description,
        :unit_price  => unit_price,
        :created_at  => created_at,
        :updated_at  => updated_at,
        :merchant_id => merchant_id
      })
    end
  end

  def all
    items_array
  end

  def find_by_id(find_id)
    items_array.find do |instance|
      instance.id == find_id
    end
  end

  def find_by_name(find_name)
    items_array.find do |instance|
      instance.name.downcase == find_name.downcase
    end
  end
end


# find_all_with_description - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
# find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches
# find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
# find_all_by_merchant_id - returns either [] or instances of Item where the supplied merchant ID matches that supplied
