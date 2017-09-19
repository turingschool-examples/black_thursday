require_relative 'repository'
require_relative 'item'

class ItemRepository < Repository

  def record_class
    Item
  end

  def find_by_name(name)
    find{ |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(substring)
    find_all do |item|
      item.description.downcase.include? substring.downcase
    end
  end

  def find_all_by_price(unit_price)
    find_all{ |item| item.unit_price == unit_price }
  end

  def find_all_by_price_in_range(unit_price_range)
    find_all{ |item| unit_price_range.include? item.unit_price }
  end

  def find_all_by_merchant_id(merchant_id)
    find_all{ |item| item.merchant_id == merchant_id }
  end

end
