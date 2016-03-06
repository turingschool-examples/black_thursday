require 'pry'

class ItemRepository

  attr_accessor :repository
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @repository = []
  end

  def all
    repository
  end

  def find_by_id(item_id)
    repository.find do |item|
      item.id == item_id
    end
  end

  def find_by_name(name)
    repository.find do |item|
      item.name.downcase.include?(name.downcase)
    end
  end

  def find_all_with_description(description)
    repository.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    x =repository.find_all do |item|
      item.unit_price.to_f == price
    end
  end

  def find_all_by_price_in_range(price_range)
    repository.find_all do |item|
      price_range.include?(item.unit_price.to_f)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    repository.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def inspect
  end

end
