require_relative 'reposable'
require_relative './item.rb'
require 'bigdecimal'

class ItemRepository
  include Reposable

  attr_accessor :all

  def initialize(all = [])
    @all = all
  end

  def find_by_name(name)
    all.find do |item|
      item.name.upcase == name.upcase
    end
  end

  def find_all_with_description(description)
    all.select do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    all.select do |item|
      item.unit_price.to_f == price
    end
  end

  def find_all_by_price_in_range(range)
    all.select do |item|
      item.unit_price.to_f >= range.begin && item.unit_price.to_f <= range.end
    end
  end

  def find_all_by_merchant_id(id)
    all.select do |item|
      item.merchant_id.to_i == id
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end