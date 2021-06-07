module Incravinable

  def find_with_id(id, collection)
    collection.find do |element|
      element.id == id
    end
  end

  def find_with_name(name, collection)
    collection.find do |element|
      element.name.downcase == name.downcase
    end
  end

  def find_all_with_name(name, collection)
    collection.find_all do |element|
      element.name.downcase.include?(name)
    end
  end

  def find_all_with_price(price, collection)
    collection.find_all do |element|
      element.unit_price == price
    end
  end

  def find_all_with_price_in_range(range, collection)
    collection.find_all do |element|
      range.include?(element.unit_price)
    end
  end

  def find_all_with_merchant_id(id, collection)
    collection.find_all do |element|
      element.merchant_id == id
    end
  end

  def remove(id, collection)
    to_delete = collection.find do |element|
      element.id == id
    end
    collection.delete(to_delete)
  end

  def time_update
    @updated_at = Time.now
  end
end
