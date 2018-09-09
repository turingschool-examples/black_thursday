# Create a repository of Item objects
#   - makes all item objects
#   - uses finder & CRUD modules

require 'pry'

require_relative 'item'
require_relative 'csv_parse'


class ItemRepository

  attr_reader :items

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    @items = []
    make_items
  end

  def make_items
    @csv.each { |key, value|
      item = Item.new( {
        # -- Read Only --
        id: key.to_s.to_i,
        :created_at = value[:created_at]
        :merchant_id: value[:merchant_id]
        # -- Accessible --
        name: value[:name],
        :description = value[:description]
        :unit_price = value[:unit_price]
        :updated_at = value[:updated_at]
      } )
      @items << merch
    }
    @items.flatten!
  end

end


# Methods
  # Finder
    # --  make module for find_by(type, attribute) --
    # --  make module for find_all_by(type, attribute) --

    # all
    # find_by_id(id)
    # find_by_name(name)
    # find_all_by_name(name)

  # Maker
    # create(attributes)
    # update(id, attributes)
    # delete(id)
