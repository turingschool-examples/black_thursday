require_relative './data_repository'
require_relative './item'

class ItemRepository < DataRepository
  def initialize(data)
    super(data, Item)
  end

  def items
    return @data_set.values
  end

  def find_all_with_description(description)
    @data_set.values.find_all do |element|
      element.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @data_set.values.find_all do |element|
      element.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @data_set.values.find_all do |element|
      range.include?(element.unit_price.to_f)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @data_set.values.find_all do |element|
      element.merchant_id == merchant_id
    end
  end
end
