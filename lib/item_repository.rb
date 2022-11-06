require 'csv'
require_relative 'item'
require 'pry'
require_relative 'repository'

class ItemRepository < Repository

  def new_obj(attributes)
    new_item = Item.new(attributes)
    @repo << new_item
    new_item
  end

  def find_by_name(name)
    @repo.find do |item|
      item.name.casecmp?(name)
    end
  end

  def find_all_with_description(description)
    @repo.find_all do |item|
      item.description.casecmp?(description)
    end
  end

  def find_all_by_price(price)
    @repo.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @repo.find_all do |item|
      range === item.unit_price
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @repo.find_all do |item|
      item.merchant_id == merchant_id
    end
  end
end
