require_relative 'repository'
require_relative 'item'

class ItemRepository < Repository
  def initialize
    @type = Item
    super
  end

  def find_all_with_description(description)
    @instances.find_all {|item| item.description.downcase == description.downcase}
  end

  def find_all_by_price(price)
    @instances.find_all {|item| item.unit_price.to_f == price.to_f}
  end

  def find_all_by_price_in_range(range)
    start_number, end_number = range.first, range.last

    @instances.find_all do |item|
      item.unit_price >= start_number && item.unit_price <= end_number
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @instances.find_all {|item| item.merchant_id == merchant_id}
  end
end
