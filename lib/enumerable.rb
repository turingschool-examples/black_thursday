module Enumerable

  def find_by_id(id)
    @all.find {|row| row.id == id}
  end

  def find_by_name(name)
    @all.find {|row| row.name.upcase == name.upcase}
  end

  def delete(id)
    key = find_by_id(id)
    @all.delete(key)
  end

  def update(id, attributes)
    key = attributes.keys[0]
    value = attributes.values[0]
    change(id, key, value)
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all {|row| row.merchant_id == merchant_id}
  end

  def create(attributes)
    last_id = @all[-1].id
    new_id = last_id + 1
    add_new(new_id, attributes)
  end

  def unit_price_to_dollars
    (@unit_price.to_f)
  end
end
