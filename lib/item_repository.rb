require_relative 'repository'
require_relative 'item'

class ItemRepository < Repository
  def create(args)
    super(Item.new(args))
  end

  def find_all_with_description(description)
    @instances.find_all {|item| item.description.downcase == description.downcase}
  end

  def find_all_by_price(price)
    @instances.find_all {|item| item.unit_price == price}
  end

  def find_all_by_price_range(range)
    start_number, end_number = range.first, range.last

    @instances.find_all do |item|
      item.unit_price >= start_number && item.unit_price <= end_number
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @instances.find_all {|item| item.merchant_id == merchant_id}
  end

  def update(id, attributes)
    found_item = find_by_id(id)
    return nil if not found_item

    update_values_with_attributes(found_item, attributes)
  end

  def update_values_with_attributes(found_item, attributes)
    attributes.each do |attribute, new_value|
      case attribute
        when :name then found_item.name = new_value
        when :description then found_item.description = new_value
        when :unit_price then found_item.unit_price = new_value
      end
    end
  end

  def find_all_by_price(price)
    @instances.find_all {|item| item.unit_price == price}
  end

  def find_all_by_price_range(range)
    start_number, end_number = range.first, range.last

    @instances.find_all do |item|
      item.unit_price >= start_number && item.unit_price <= end_number
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @instances.find_all {|item| item.merchant_id == merchant_id}
  end

  def update(id, attributes)
    found_item = find_by_id(id)
    return nil if not found_item

    update_values_with_attributes(found_item, attributes)
  end

  def update_values_with_attributes(found_item, attributes)
    attributes.each do |attribute, new_value|
      case attribute
        when :name then found_item.name = new_value
        when :description then found_item.description = new_value
        when :unit_price then found_item.unit_price = new_value
      end
    end
  end
end
