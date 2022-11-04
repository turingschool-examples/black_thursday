require 'csv'
require_relative './item'
require 'pry'
class ItemRepository
  attr_reader :repo

  def initialize
    @repo = []
  end

  def all
    @repo
  end

  def find_by_id(id)
    repo.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    repo.find do |item|
      item.name.casecmp?(name)
    end
  end

  def find_all_with_description(description)
    repo.find_all do |item|
      item.description.casecmp?(description)
    end
  end

  def find_all_by_price(price)
    repo.find_all do |item|
      # binding.pry
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    repo.find_all do |item|
      range === item.unit_price
    end
  end

  def find_all_by_merchant_id(merchant_id)
      repo.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    unless repo.empty?
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
    repo.delete_if { |item| item.id == id }
  end

  def inspect
    "#<#{self.class} #{@repo.size} rows>"
  end
end
