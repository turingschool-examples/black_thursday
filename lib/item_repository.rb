require_relative 'helper'

class ItemRepository

  attr_reader :all,
              :parent

  def initialize(item_data, parent)
    @all = item_data.map { |raw_item| Item.new(raw_item, self)}
    @parent = parent
  end

  def find_by_id(id)
    @all.find do |item|
      id == item.id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      name == item.name
    end
  end

  def find_all_with_description(fragment)
    all.find_all do |item|
      item.description.downcase.include?(fragment.downcase)
    end
  end

  def find_all_by_price(price)
    all.find_all do |item|
      price == item.unit_price
    end
  end

  def find_all_by_price_in_range(price_range)
    all.find_all do |item|
      price_range.include?(item.unit_price.to_f)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |item|
      merchant_id == item.merchant_id
    end
  end

  def find_merchant(merchant_id)
    parent.merchants.find_by_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
