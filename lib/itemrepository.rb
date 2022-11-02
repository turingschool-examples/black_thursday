require_relative 'reposable'

class ItemRepository
  include Reposable

  attr_reader :all

  def initialize(all = [])
    @all = all
  end

  def find_by_name(name)
    all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    all.select do |item|
      item.description.include? description
    end
  end

  def find_all_by_price(price)
    all.select do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    all.select do |item|
      item.unit_price >= range.begin && item.unit_price <= range.end
    end
  end

  def find_all_by_merchant_id(id)
    all.select do |item|
      item.merchant_id == id.to_s
    end
  end
end