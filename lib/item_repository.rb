require 'csv'
require_relative './item'
class ItemRepository
  attr_reader :repo

  def inspect
    "#<#{self.class} #{@repo.size} rows>"
  end

  def initialize
    @repo = []
  end

  def all
    @repo
  end

  def find_by_id(id)
    all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    all.find do |item|
      item.name == name.downcase
    end
  end

  def find_all_with_description(description)
    all.find_all do |item|
      item.description == description.downcase
    end
  end

  def find_all_by_price(price)
    all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    all.find_all do |item|
      range === item.unit_price
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    unless all.empty?
      attributes[:id] = all.max do |item|
        item.id
      end.id + 1
    end
    new_item = Item.new(attributes)
    @repo << new_item
    new_item
  end

  def update(id, attributes)
    find_by_id(id).update(attributes)
  end

  def delete(id)
    all.delete_if { |item| item.id == id }
  end
end
