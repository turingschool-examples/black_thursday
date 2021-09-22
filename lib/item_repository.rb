# frozen_string_literal: true
require 'csv'
require_relative '../lib/item'
require_relative '../lib/repoable'


class ItemRepository
  include Repoable
  attr_reader :all

  def initialize(path)
    @path = path
    @all = to_array
  end

  def create_array_of_objects(things)
    things.map do | item |
      Item.new(item)
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

  def create(attributes)
    id = find_highest_id + 1
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
    end
    if attributes[:description] != nil
      find_by_id(id).change_description(attributes[:description])
    end
    if attributes[:unit_price] != nil
      find_by_id(id).change_unit_price(attributes[:unit_price])
    end
  end
end
