require 'csv'

class ItemRepo
  attr_reader :item_list

  def initialize(input)
    make_items(input)
  end

  def make_items(input)
    items = CSV.open(input, headers: true,
    header_converters: :symbol)

    @item_list = items.map do |item|
      Item.new(item)
    end
  end

  def all
    item_list
  end

  def find_by_id(id)
    if id.nil?
      nil
    else
       @item_list.find do |item|
        item.id == id
      end
    end
  end

  def find_by_name(name)
    if name.nil?
      nil
    else
       @item_list.find do |item|
        item.name == name
      end
    end
  end

  def find_all_by_description(description)
    description = description.downcase

    return [] if description.nil?

    @item_list.find_all do |item|
      item.description.downcase.include?(description)
    end
  end

  def find_all_by_price(price)
    return [] if price.nil?

    @item_list.find_all do |item|
      item.unit_price_to_dollars == price
    end
  end


end
